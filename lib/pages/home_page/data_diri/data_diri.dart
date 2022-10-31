import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/login_page/components/input_field.dart';
import 'package:mini_projeck/pages/login_page/components/login_button.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:provider/provider.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _DataDiriState();
}

final _formkey = GlobalKey<FormState>();
final _namaC = TextEditingController();
final _nisnC = TextEditingController();

class _DataDiriState extends State<DataDiri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(
                height: getPropertionateScreenHeight(32),
              ),
              InputField(
                  hintText: 'Nama',
                  keyboardType: TextInputType.name,
                  controller: _namaC,
                  validator: () {
                    if (_namaC.text == null || _namaC.text.isEmpty) {
                      return 'Mohon Masukkan Nama Anda.';
                    } else {
                      return null;
                    }
                  }),
              InputField(
                  hintText: 'NISN',
                  keyboardType: TextInputType.name,
                  controller: _nisnC,
                  validator: () {
                    if (_nisnC.text == null || _nisnC.text.isEmpty) {
                      return 'Mohon Masukkan Nama NISN.';
                    } else {
                      return null;
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
