import 'package:flutter/material.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/regis_page/regis_page.dart';

class BelumPunyaAkun extends StatefulWidget {
  BelumPunyaAkun({
    Key? key,
  }) : super(key: key);

  @override
  State<BelumPunyaAkun> createState() => _BelumPunyaAkunState();
}

class _BelumPunyaAkunState extends State<BelumPunyaAkun> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum Punya',
          style: primaryTextStyle.copyWith(fontSize: 14, fontWeight: light),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisPage(),
                ));
          },
          child: Text(
            ' Akun?',
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: light,
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
