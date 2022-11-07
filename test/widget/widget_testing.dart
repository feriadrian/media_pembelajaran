import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/spalsh_page/splash_page.dart';

void main() {
  testWidgets('finds a scaffold widget', (tester) async {
    await tester.pumpWidget(
      HomePage(),
    );

    expect(find.byWidget(Scaffold()), findsOneWidget);
  });

  testWidgets('finds a specific instance', (tester) async {
    var childWidget = Padding(padding: EdgeInsets.all(defaultPadding));

    await tester.pumpWidget(Container(child: childWidget));

    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
