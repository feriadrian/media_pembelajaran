import 'package:flutter/material.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/models/users_models.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/pages/login_page/components/masuk_sebagai_admin.dart';
import 'package:mini_projeck/provider/user_provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModels userModel = userProvider.allUsers;
    SizeConfig().init(context);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          color: kPrimaryColor,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: getPropertionateScreenHeight(812 - 555),
                  decoration: BoxDecoration(color: kPrimaryColor),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  width: double.infinity,
                  height: getPropertionateScreenHeight(555),
                  decoration: BoxDecoration(
                    color: kBackgroundColor2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: getPropertionateScreenHeight(38),
                      ),
                      Center(
                        child: Text(
                          'Login',
                          style: primaryTextStyle.copyWith(
                              fontSize: 36, fontWeight: bold),
                        ),
                      ),
                      SizedBox(
                        height: getPropertionateScreenHeight(31),
                      ),
                      InputField(
                        validator: () {
                          if (_emailC.text == null || _emailC.text.isEmpty) {
                            return 'Please Enter Your Email.';
                          } else {
                            return null;
                          }
                        },
                        controller: _emailC,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: getPropertionateScreenHeight(18),
                      ),
                      InputField(
                        validator: () {
                          if (_passC.text == null || _passC.text.isEmpty) {
                            return 'Please Enter Your Password.';
                          } else {
                            return null;
                          }
                        },
                        controller: _passC,
                        hintText: 'Password',
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(
                        height: getPropertionateScreenHeight(35),
                      ),
                      LoginButton(
                        text: 'Login',
                        press: () async {
                          if (await userProvider.login(
                              _emailC.text, _passC.text)) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
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
                      Spacer(),
                      BelumPunyaAkun(),
                      SizedBox(
                        height: getPropertionateScreenHeight(24),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
