import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/pages/regis_page/components/regis_button.dart';
import 'package:mini_projeck/provider/user_provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';

class RegisPage extends StatefulWidget {
  RegisPage({super.key});

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _formkey = GlobalKey<FormState>();

  final _emailC = TextEditingController();

  final _passC = TextEditingController();
  final _namaC = TextEditingController();
  final _nisnC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    _namaC.dispose();
    _nisnC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                InputField(
                    validator: () {
                      if (_emailC.text.isEmpty) {
                        return 'Mohom Masukkan Email.';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailC),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                InputField(
                    validator: () {
                      if (_namaC.text.isEmpty) {
                        return 'Mohom Masukkan Nama.';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Nama',
                    keyboardType: TextInputType.emailAddress,
                    controller: _namaC),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                InputField(
                    validator: () {
                      if (_nisnC.text.isEmpty) {
                        return 'Mohom Masukkan NiSN.';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'NISN',
                    keyboardType: TextInputType.emailAddress,
                    controller: _nisnC),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                InputField(
                    validator: () {
                      if (_passC.text.isEmpty) {
                        return 'Mohom Masukkan Password.';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Password',
                    keyboardType: TextInputType.text,
                    controller: _passC),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                Spacer(),
                LoginButton(
                  text: 'Regis',
                  press: () async {
                    final String role = 'siswa';
                    if (await AuthServices().regis(
                      email: _emailC.text,
                      password: _passC.text,
                      nama: _namaC.text,
                      nisn: _nisnC.text,
                      role: role,
                    )) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            AuthServices().error.toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
