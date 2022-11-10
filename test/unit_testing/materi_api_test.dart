import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_projeck/provider/materi_provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:mini_projeck/services/materi_services.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

@GenerateMocks([MateriServices])
void main() {
  group(
    'Materi Services',
    () {
      test(
        'Get Materi Bilangan Bulat',
        () async {
          final kategori = 'Bilangan Bulat';
          MateriServices materiServices = MateriServices();
          var materis = await materiServices.inisialData(kategori);
          expect(materis, isA());
        },
      );
      test(
        'Post Materi',
        () async {
          MateriServices materiServices = MateriServices();
          var materis =
              await materiServices.addMateri('bab', 'judul', 'urlMateri');
          expect(materis.url, isA());
        },
      );
      test(
        'Get All Materi',
        () async {
          MateriServices materiServices = MateriServices();
          List kategori = ['Bilangan Bulat', 'Himpunan', 'Aljabar', 'PLSV'];
          var materis = await materiServices.inisialData(kategori.toString());
          expect(materis, isA());
        },
      );
    },
  );
}
