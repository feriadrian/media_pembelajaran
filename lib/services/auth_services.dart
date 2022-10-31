import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mini_projeck/provider/provider.dart';
import 'package:provider/provider.dart';

class AuthSerices extends ChangeNotifier {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  String _error = '';
  String get error => _error;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<bool> regis({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = _auth.currentUser!;
      final localId = user.uid;
      final String role = 'siswa';
      await UserProvider().singUp(email, password);
      _error = '';
      final String nama = '-';
      final String nisn = '-';

      await UserProvider().addUsers(localId, email, nama, nisn, role);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await UserProvider().singIn(email, password);
      _error = '';

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
}
