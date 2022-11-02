import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<AuthSerices>(context);
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    color: kPrimaryLightColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: getPropertionateScreenWidht(60),
                        backgroundColor: kPrimaryColor,
                        backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/a-/AFdZucovlo2puumagCeN9t8yLO5YVfa9mS_iBb16GMyfuw=s288-p-rw-no'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Diri',
                      style: primaryTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: getPropertionateScreenHeight(20),
                    ),
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: getPropertionateScreenWidht(40),
                        ),
                        Text(
                          'Feri Adrian',
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getPropertionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(
                          width: getPropertionateScreenWidht(40),
                        ),
                        Text(
                          '1924038',
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getPropertionateScreenHeight(10),
                    ),
                    InkWell(
                      onTap: () {
                        _userProvider.logout();
                      },
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
                            'Keluar',
                            style: GoogleFonts.redHatDisplay(
                                fontWeight: semiBold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
