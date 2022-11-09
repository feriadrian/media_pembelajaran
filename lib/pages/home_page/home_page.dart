import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/pages/home_page/component/custom_drawer.dart';
import 'package:mini_projeck/pages/home_page/component/header.dart';
import 'package:mini_projeck/pages/home_page/component/list_cover_gridview.dart';
import 'package:mini_projeck/pages/home_page/component/qoute_card.dart';
import 'package:mini_projeck/pages/tambah_materi_page/tambah_materi_page.dart';
import 'package:mini_projeck/provider/materi_provider.dart';
import 'package:mini_projeck/provider/user_provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModels userModel = userProvider.allUsers;
    return Scaffold(
      floatingActionButton: userModel.role == "admin"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const TambahMateriPage(),
                    transitionDuration: Duration(milliseconds: 700),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : SizedBox(),
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              HeaderHome(scaffoldKey: _scaffoldKey),
              SizedBox(
                height: getPropertionateScreenHeight(31),
              ),
              QuoteCard(),
              SizedBox(
                height: getPropertionateScreenHeight(24),
              ),
              Text(
                'Silahkan Pilihan Materi Dibawah',
                style:
                    primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              SizedBox(
                height: getPropertionateScreenHeight(24),
              ),
              Expanded(
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: GridMateri(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
