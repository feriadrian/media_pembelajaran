import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';

class MateriCard extends StatelessWidget {
  const MateriCard({super.key, required this.judulMateri, required this.url});

  final String judulMateri;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 7 / 10,
              padding: EdgeInsets.all(
                getPropertionateScreenWidht(10),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  judulMateri,
                  style:
                      primaryTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
