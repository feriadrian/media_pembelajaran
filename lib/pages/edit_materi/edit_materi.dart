import 'package:flutter/material.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/provider/materi_provider.dart';
import 'package:provider/provider.dart';

class EditMateri extends StatelessWidget {
  EditMateri(
      {super.key,
      required this.bab,
      required this.id,
      required this.judul,
      required this.url});

  final String bab;
  final String id;
  final String judul;
  final String url;

  final _formkey = GlobalKey<FormState>();
  TextEditingController _judulC = TextEditingController();
  TextEditingController _urlC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _MateriProvider = Provider.of<MateriProvider>(context);
    _judulC.text = judul;
    _urlC.text = url;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                InputField(
                  hintText: 'Judul Materi',
                  keyboardType: TextInputType.text,
                  controller: _judulC,
                  validator: () {
                    if (_judulC.text == null || _judulC.text.isEmpty) {
                      return 'Please Enter Your Email.';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                InputField(
                  hintText: 'Link Video',
                  keyboardType: TextInputType.text,
                  controller: _urlC,
                  validator: () {
                    if (_urlC.text == null || _urlC.text.isEmpty) {
                      return 'Please Enter Your Email.';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                LoginButton(
                  text: 'Edit',
                  press: () async {
                    print(_judulC.text);
                    if (_formkey.currentState!.validate()) {
                      await _MateriProvider.editmateri(
                          id, _judulC.text, _urlC.text, bab);
                      Navigator.pop(context);
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
