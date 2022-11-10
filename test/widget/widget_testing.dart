import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/main.dart';
import 'package:mini_projeck/pages/home_page/component/qoute_card.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/materi_page/components/materi_card.dart';
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

  testWidgets('Find Container child align', (WidgetTester tester) async {
    final _childWidget = Align();
    await tester.pumpWidget(Container(
      child: _childWidget,
    ));
    expect(find.byWidget(_childWidget), findsOneWidget);
  });

  testWidgets('Find Container with spesific padding', (tester) async {
    final childWidget = Padding(
      padding: EdgeInsets.symmetric(
          vertical: getPropertionateScreenHeight(28),
          horizontal: getPropertionateScreenWidht(3)),
    );

    await tester.pumpWidget(Container(child: childWidget));

    expect(find.byWidget(childWidget), findsOneWidget);
  });

  // testWidgets('Find QouteCard Widget At HomePage', (WidgetTester tester) async {
  //   await tester.pumpWidget(MyApp());
  //   var qouteCard = find.byWidget(QuoteCard());
  //   expect(qouteCard, findsOneWidget);
  // });
}
