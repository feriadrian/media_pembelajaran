import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  final Function() press;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: getPropertionateScreenHeight(58),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(
            getPropertionateScreenWidht(12),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.redHatDisplay(
                fontWeight: semiBold, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
