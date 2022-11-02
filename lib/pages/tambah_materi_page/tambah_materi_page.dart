import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:provider/provider.dart';

class TambahMateriPage extends StatefulWidget {
  const TambahMateriPage({super.key});

  @override
  State<TambahMateriPage> createState() => _TambahMateriPageState();
}

class _TambahMateriPageState extends State<TambahMateriPage> {
  final _formkey = GlobalKey<FormState>();

  final _judulC = TextEditingController();

  final _urlC = TextEditingController();

  @override
  void dispose() {
    _judulC.dispose();
    _urlC.dispose();
    super.dispose();
  }

  String _value = 'Bilangan Bulat';
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
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
                buildKelas(
                  press: (value) {
                    setState(() {
                      print("data: " + value);
                      _value = value;
                    });
                  },
                  hintText: 'Pilih BAB',
                ),
                SizedBox(
                  height: getPropertionateScreenHeight(24),
                ),
                LoginButton(
                  text: 'Tambah',
                  press: () async {
                    if (_formkey.currentState!.validate()) {
                      await _userProvider
                          .addMateri(_value, _judulC.text, _urlC.text)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Berhasil Ditambahkan'),
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                      });
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

Container buildKelas(
    {required String hintText, required Function(String value) press}) {
  List<String> list = [
    'Bilangan Bulat',
    'Himpunan',
    'Aljabar',
    'PLSV',
  ];
  return Container(
    child: DropdownButtonFormField2(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: subtitleTextStyle.copyWith(
          fontSize: 14,
        ),
      ),
      isExpanded: true,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: list
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.toString(),
                  style: primaryTextStyle,
                ),
              ))
          .toList(),
      onChanged: (value) {
        press(value.toString());
      },
      onSaved: (value) {
        // press(value.toString());
      },
    ),
  );
}
