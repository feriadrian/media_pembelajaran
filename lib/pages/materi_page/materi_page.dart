import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_projeck/pages/materi_page/components/list_materi.dart';
import 'package:mini_projeck/pages/materi_page/components/materi_card.dart';
import 'package:mini_projeck/pages/video_page/video_page.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key, required this.kategori});

  @override
  State<MateriPage> createState() => _MateriPageState();
  final String kategori;
}

class _MateriPageState extends State<MateriPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserProvider>(context).inisialData(widget.kategori);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    isInit = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _userProvider.allMateri
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPage(),
                          ),
                        );
                      },
                      child: MateriCard(
                        judulMateri: e.judul,
                        url: e.url,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}