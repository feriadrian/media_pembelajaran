import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropertionateScreenWidht(56),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi, Bro',
                style:
                    primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              Text(
                'Ayo Mulai Belajar',
                style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                    color: kSubtitleTextColor),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
