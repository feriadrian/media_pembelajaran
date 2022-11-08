import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_projeck/main.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/spalsh_page/splash_page.dart';

void main() {
  testWidgets('Find TextFiled', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var textFiled = find.byType(SplashPage);
    expect(textFiled, findsOneWidget);
  });
  testWidgets('Find Widget Scaffold At HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var scaffold = find.byType(Scaffold);
    expect(scaffold, findsOneWidget);
  });

  testWidgets('Find Text ', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Ayo Mulai Belajar'), findsOneWidget);
  });

  testWidgets('Find Text', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Silahkan Pilihan Materi Dibawah'), findsOneWidget);
  });
}
