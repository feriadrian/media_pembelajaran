import 'package:flutter_test/flutter_test.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'materi_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('MateriApi', () async {
    final client = MockClient();

    when(client.get(Uri.parse(
            'https://mini-project-26683-default-rtdb.firebaseio.com/materi/Himpunan/-NFsOoCZU_pO9X60zHG7')))
        .thenAnswer((_) async => http.Response(
            '{"judul": "Konsep Himpunan", "url": "https://www.youtube.com/watch?v=lldr0vofEKo"}',
            200));
    final materi = await fetchMateri(client);
    expect(materi, isA<ModelMateri>());
    expect(materi.judul, 'Konsep Himpunan');
    expect(materi.url, 'https://www.youtube.com/watch?v=lldr0vofEKo');
  });
}
