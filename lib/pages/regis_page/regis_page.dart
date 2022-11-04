import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/pages/regis_page/components/regis_button.dart';
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

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthSerices>(context);
    SizeConfig().init(context);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Container(
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
                          if (await authServices.regis(
                              email: _emailC.text, password: _passC.text)) {
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => HomePage(),
                            //     ),
                            //     (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  authServices.error.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
