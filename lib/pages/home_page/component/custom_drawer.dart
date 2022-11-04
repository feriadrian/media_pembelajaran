import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/pages/login_page/login_page.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthSerices>(context);
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User _user = _auth.currentUser!;
    final localId = _user.uid;

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
                          _authProvider.allUsers.nama,
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
                          _authProvider.allUsers.nins,
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getPropertionateScreenHeight(10),
                    ),
                    InkWell(
                      onTap: () async {
                        final pref = await SharedPreferences.getInstance();

                        pref.remove('token');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false);
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
