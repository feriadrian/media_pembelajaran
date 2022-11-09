import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  String baseUrl = 'https://mini-project-26683-default-rtdb.firebaseio.com/';

  Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  String _error = '';
  String get error => _error;

  Future<UserModels> addUsers(String nama, nisn, String role) async {
    Uri url = Uri.parse('$baseUrl/users.json');
    final User user = _auth.currentUser!;
    final id = user.uid;
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'id': id,
          'nama': nama,
          'nisn': nisn,
          'role': role,
        }),
      );

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        UserModels data = UserModels(
          id: id,
          nama: nama,
          nins: nisn,
          role: role,
        );
        return UserModels(
          id: id,
          nama: nama,
          nins: nisn,
          role: role,
        );
      }
    } catch (err) {
      throw (err);
    }
  }

  Future<UserModels> fetchDataUser(
    String id,
  ) async {
    Uri uri = Uri.parse('$baseUrl/users.json');
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
                  nama: value['nama'],
                  nins: value['nisn'],
                  role: value['role'],
                );
                print(userModels!.nama.toString());
              }
            },
          );
        } else {
          print('daa null');
        }
      }

      return userModels!;
    } catch (err) {
      return throw (err);
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final User _user = _auth.currentUser!;
      final token = await _user.getIdToken();
      final localId = _user.uid;

      setToken(localId);

      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message.toString();
    }
    return false;
  }

  Future<bool> regis({
    required String email,
    required String password,
    required String nama,
    required String nisn,
    required String role,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserProvider().addUsers(nama, nisn, role);

      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message.toString();
    }
    return false;
  }
}
