import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';

class RegisButton extends StatelessWidget {
  const RegisButton({
    Key? key,
    required this.press,
  }) : super(key: key);

  final Function() press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      child: Text('Register'),
    );
  }
}
