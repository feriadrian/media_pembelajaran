import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/materi_model.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/services/services.dart';

class UserProvider extends ChangeNotifier {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  UserModels? _allUsers;
  List<MateriModel> _allMateri = [];
  List<MateriModel> get allMateri => _allMateri;

  UserModels get allUsers => _allUsers!;

  String urlMaster = 'https://mini-project-26683-default-rtdb.firebaseio.com/';

  Future<UserModels> fetchDataUser(
    String id,
  ) async {
    Uri uri = Uri.parse('$urlMaster/users.json');
    // final User user = _auth.currentUser!;
    // final uid = user.uid;
    try {
      var response = await http.get(uri);

      print(response.statusCode);

      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        UserModels? userModels;
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
                _allUsers = userModels;
                print(_allUsers!.nama.toString());
              }
            },
          );
        } else {
          print('daa null');
        }
      }
      notifyListeners();
      return _allUsers!;
    } catch (err) {
      throw (err);
    }
  }

  Future<void> addMateri(String bab, String judul, String urlMateri) async {
    print(bab);
    Uri url = Uri.parse('$urlMaster/materi/$bab.json');
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'judul': judul,
          'url': urlMateri,
        }),
      );

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        MateriModel data = MateriModel(
          id: json.decode(response.body)['judul'].toString(),
          judul: judul,
          url: urlMateri,
        );

        _allMateri.add(data);
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  Future<void> deleteMateri(String id, String bab) {
    Uri url = Uri.parse('$urlMaster/materi/$bab/$id.json');
    return http.delete(url).then(
      (response) {
        _allMateri.removeWhere((element) => element.id == id);
        notifyListeners();
      },
    );
  }

  Future<void> addUsers(
      String id, String email, String nama, String nisn, String role) async {
    Uri url = Uri.parse('$urlMaster/users.json');
    DateTime dateNow = DateTime.now();

    try {
      var response = await http.post(
        url,
        body: json.encode({
          'id': id,
          'email': email,
          'nama': nama,
          'nisn': nisn,
          'role': role,
          'createAt': dateNow.toString(),
          'updateAt': dateNow.toString(),
        }),
      );

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        UserModels data = UserModels(
          id: json.decode(response.body)["name"].toString(),
          email: email,
          nama: nama,
          nins: nisn,
          role: role,
          createAt: dateNow,
        );

        _allUsers = data;
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  Stream<List<MateriModel>> inisialData(String kategory) async* {
    _allMateri = [];
    Uri url = Uri.parse('$urlMaster/materi/$kategory.json');

    try {
      var response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        if (data != null) {
          data.forEach(
            (key, value) {
              _allMateri.add(MateriModel(
                  id: key, judul: value['judul'], url: value['url']));
            },
          );
        }
      }
      yield _allMateri;
    } catch (err) {
      throw (err);
    }
  }

  MateriModel selectById(String id) =>
      _allMateri.firstWhere((element) => element.id == id);

  Future<void> editmateri(String id, String judul, String urlEdit, String bab) {
    Uri url = Uri.parse('$urlMaster/materi/$bab/$id.json');

    return http
        .put(
      url,
      body: json.encode(
        {
          'judul': judul,
          'url': urlEdit,
        },
      ),
    )
        .then(
      (response) {
        MateriModel selecteMateri =
            _allMateri.firstWhere((element) => element.id == id);
        selecteMateri.judul = judul;
        selecteMateri.url = url.toString();
        notifyListeners();
      },
    );
  }

  // Future<void> fetchUserById() async {
  //   _allUsers = [];
  //   FirebaseAuth _auth = FirebaseAuth.instance;

  //   final User user = _auth.currentUser!;
  //   final localId = user.uid;
  //   Uri url = Uri.parse(
  //       '$urlMaster/products.json=orderBy="userId"&equalTo="$localId"');

  //   try {
  //     var response = await http.get(url);

  //     print(response.statusCode);

  //     if (response.statusCode >= 300 && response.statusCode < 200) {
  //       throw (response.statusCode);
  //     } else {
  //       var data = json.decode(response.body) as Map<String, dynamic>;
  //       if (data.isNotEmpty) {
  //         data.forEach(
  //           (key, value) {
  //             UserModels _users = UserModels(
  //               id: key,
  //               email: value["email"],
  //               nama: value["nama"],
  //               nins: value["nisn"],
  //               role: value["role"],
  //               createAt:
  //                   DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["createdAt"]),
  //               updateAt:
  //                   DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["updatedAt"]),
  //             );
  //             _allUsers.add(_users);
  //             notifyListeners();
  //           },
  //         );
  //       }
  //     }
  //   } catch (err) {
  //     throw (err);
  //   }
  // }

  Future<void> singUp(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBLoyyGLhfyw2K-kNdIcVluwjDy5mXvIVE');
    var response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(json.decode(response.body));
  }

  Future<void> singIn(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBLoyyGLhfyw2K-kNdIcVluwjDy5mXvIVE');
    var response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(json.decode(response.body));
  }
}
