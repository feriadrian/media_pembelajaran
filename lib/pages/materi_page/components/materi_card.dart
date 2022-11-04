import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/constant/constant.dart';
import 'package:mini_projeck/pages/edit_materi/edit_materi.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:provider/provider.dart';

class MateriCard extends StatelessWidget {
  const MateriCard({
    super.key,
    required this.judulMateri,
    required this.url,
    required this.id,
    required this.bab,
  });

  final String judulMateri;
  final String id;
  final String url;
  final String bab;

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthSerices>(context);
    final _userProvider = Provider.of<UserProvider>(context);
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
            _authProvider.allUsers.role == 'admin'
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // print('$babs');
                          _userProvider.deleteMateri(id, bab);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditMateri(
                                judul: judulMateri,
                                url: url,
                                bab: bab,
                                id: id,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  )
                : SizedBox()
          ],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
