import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constant/constant.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Function() validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator(),
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kAlert,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kAlert,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: EdgeInsets.only(
          left: getPropertionateScreenWidht(20),
          top: getPropertionateScreenWidht(18),
          bottom: getPropertionateScreenWidht(18),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: GoogleFonts.redHatDisplay(
          fontSize: 16,
          fontWeight: regular,
        ),
      ),
    );
  }
}
