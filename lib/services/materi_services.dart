import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_projeck/models/materi_model.dart';

class MateriServices {
  String baseUrl = 'https://mini-project-26683-default-rtdb.firebaseio.com/';

  Future<MateriModel> addMateri(
      String bab, String judul, String urlMateri) async {
    print(bab);
    Uri url = Uri.parse('$baseUrl/materi/$bab.json');
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
        return MateriModel(
            id: json.decode(response.body)['judul'].toString(),
            judul: judul,
            url: urlMateri);
      }
    } catch (err) {
      throw (err);
    }
  }

  Stream<List<MateriModel>> inisialData(String kategory) async* {
    List<MateriModel> _allMateri = [];
    Uri url = Uri.parse('$baseUrl/materi/$kategory.json');

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

  Future<void> deleteMateri(String id, String bab) {
    Uri url = Uri.parse('$baseUrl/materi/$bab/$id.json');
    return http.delete(url);
  }

  Future<void> editmateri(
      {required String id,
      required String judul,
      required String urlEdit,
      required String bab}) {
    Uri url = Uri.parse('$baseUrl/materi/$bab/$id.json');

    return http.put(
      url,
      body: json.encode(
        {
          'judul': judul,
          'url': urlEdit,
        },
      ),
    );
  }
}
