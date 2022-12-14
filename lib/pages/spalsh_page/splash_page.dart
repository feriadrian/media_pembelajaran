import 'package:flutter/material.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/login_page/login_page.dart';
import 'package:mini_projeck/provider/materi_provider.dart';
import 'package:mini_projeck/provider/user_provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  late SharedPreferences loginData;
  late String newUser;

  void initState() {
    getToken();
    print('on init');
    super.initState();
  }

  void getToken() async {
    final loginData = await SharedPreferences.getInstance();
    final String token = loginData.getString('token') ?? '';
    if (token != '') {
      print(token);
      var data = await Provider.of<UserProvider>(context, listen: false)
          .fetchDataUser();
      print('complete: ' + data.role.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/STKIP_YPUP.png',
          width: getPropertionateScreenWidht(121.11),
          height: getPropertionateScreenWidht(115),
        ),
      ),
    );
  }
}
