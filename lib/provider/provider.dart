import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/materi_model.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/services/services.dart';

class MateriProvider extends ChangeNotifier {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  List<MateriModel> _allMateri = [];
  List<MateriModel> get allMateri => _allMateri;

  String urlMaster = 'https://mini-project-26683-default-rtdb.firebaseio.com/';

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

        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }
}

Future<ModelMateri> fetchMateri(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://mini-project-26683-default-rtdb.firebaseio.com/materi/Himpunan/-NFsOoCZU_pO9X60zHG7'));

  if (response.statusCode == 200) {
    return ModelMateri.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class ModelMateri {
  final String judul;
  final String url;

  ModelMateri({required this.judul, required this.url});

  static ModelMateri fromJson(Map<String, dynamic> json) {
    return ModelMateri(
      judul: json['judul'],
      url: json['url'],
    );
  }
}
