import 'package:flutter/material.dart';
import 'package:mini_projeck/config/config.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
