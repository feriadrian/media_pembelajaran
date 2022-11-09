import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/materi_model.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/services/materi_services.dart';

class MateriProvider extends ChangeNotifier {
  List<MateriModel> _allMateri = [];
  List<MateriModel> get allMateri => _allMateri;

  Future<void> addMateri(String bab, String judul, String urlMateri) async {
    try {
      final result = await MateriServices().addMateri(bab, judul, urlMateri);
      if (result.id != null) {
        _allMateri.add(result);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMateri(String id, String bab, String judul) async {
    try {
      final index = _allMateri.indexWhere((element) => element.judul == judul);
      if (index != null) {
        await MateriServices().deleteMateri(id, bab).then(
              (value) => _allMateri.removeAt(index),
            );
        print('succes');
      }
      notifyListeners();
    } catch (e) {
      print('gagal: $e');
    }
  }

  Future<void> editmateri(
      String id, String judul, String urlEdit, String bab) async {
    try {
      final index = _allMateri.indexWhere((element) => element.judul == judul);
      if (index != null) {
        await MateriServices()
            .editmateri(bab: bab, id: id, judul: judul, urlEdit: urlEdit);
      }
      notifyListeners();
    } catch (e) {
      print('gagal: $e');
    }
  }

  Future<void> getAllMateri(String kategori) async {
    await MateriServices().inisialData(kategori);
  }
}

  

// Future<ModelMateri> fetchMateri(http.Client client) async {
//   final response = await client.get(Uri.parse(
//       'https://mini-project-26683-default-rtdb.firebaseio.com/materi/Himpunan/-NFsOoCZU_pO9X60zHG7'));

//   if (response.statusCode == 200) {
//     return ModelMateri.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

// class ModelMateri {
//   final String judul;
//   final String url;

//   ModelMateri({required this.judul, required this.url});

//   static ModelMateri fromJson(Map<String, dynamic> json) {
//     return ModelMateri(
//       judul: json['judul'],
//       url: json['url'],
//     );
//   }
// }
