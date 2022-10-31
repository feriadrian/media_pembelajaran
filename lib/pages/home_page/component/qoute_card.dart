import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(
          vertical: getPropertionateScreenHeight(28),
          horizontal: getPropertionateScreenWidht(3)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryLightColor,
            kPrimaryColor,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset('assets/quote_illustration1.svg'),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Pendidikan adalah senjata paling ampuh yang bisa digunakan untuk mengubah dunia',
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
