import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/services/auth_services.dart';

class UserProvider extends ChangeNotifier {
  UserModels _allUsers = UserModels(id: '', nama: '', nins: '', role: '');
  UserModels get allUsers => _allUsers;

  set allUsers(UserModels allUsers) {
    _allUsers = allUsers;
    notifyListeners();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUsers(String nama, String nisn, String role) async {
    try {
      final result = await AuthServices().addUsers(nama, nisn, role);
      if (result.id != null) {
        _allUsers = result;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModels> fetchDataUser() async {
    try {
      final User _user = _auth.currentUser!;
      final localId = _user.uid;
      var data = await AuthServices().fetchDataUser(localId);

      _allUsers = data;
      print("Data: " + _allUsers.role);
      print('on ori');

      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final User _user = _auth.currentUser!;
      final localId = _user.uid;
      var data = await AuthServices().login(email: email, password: password);
      await fetchDataUser();
      notifyListeners();
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
