import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSerices extends ChangeNotifier {
  String urlMaster = 'https://mini-project-26683-default-rtdb.firebaseio.com/';

  UserModels? _allUsers;

  UserModels get allUsers => _allUsers!;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
  }

  String _error = '';
  String get error => _error;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<bool> login({required String email, required String password}) async {
    try {
      // UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User _user = _auth.currentUser!;
      final localId = _user.uid;

      setToken(localId);

      // print(setToken(await _user.getIdToken()));
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await MateriProvider().singIn(email, password);

      _error = '';

      _allUsers = await fetchDataUser(localId);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> regis({
    required String email,
    required String password,
  }) async {
    try {
      // UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = _auth.currentUser!;
      final localId = user.uid;

      final String role = 'siswa';
      await MateriProvider().singUp(email, password);
      _error = '';
      final String nama = '-';
      final String nisn = '-';

      await MateriProvider().addUsers(localId, email, nama, nisn, role);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message.toString();
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<UserModels> fetchDataUser(
    String id,
  ) async {
    Uri uri = Uri.parse('$urlMaster/users.json');
    // final User user = _auth.currentUser!;
    // final uid = user.uid;
    try {
      var response = await http.get(uri);

      print(response.statusCode);

      UserModels? userModels;
      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        if (data != null) {
          data.forEach(
            (key, value) {
              if (value['id'] == id) {
                userModels = UserModels(
                  id: key,
                  email: value['email'],
                  nama: value['nama'],
                  nins: value['nisn'],
                  role: value['role'],
                  createAt: DateTime.now(),
                );
                print(userModels!.nama.toString());
              }
            },
          );
        } else {
          print('daa null');
        }
      }
      _allUsers = userModels;
      notifyListeners();
      return userModels!;
    } catch (err) {
      throw (err);
    }
  }
}
