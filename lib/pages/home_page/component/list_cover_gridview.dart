import 'package:flutter/material.dart';
import 'package:mini_projeck/config/config.dart';
import 'package:mini_projeck/pages/materi_page/materi_page.dart';

class GridMateri extends StatelessWidget {
  const GridMateri({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> category = ['Bilangan Bulat', 'Himpunan', 'Aljabar', 'PLSV'];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: listCover.length,
      itemBuilder: (context, index) {
        ListCover model = listCover[index];
        return CardMateri(
          imageAssets: model.cover,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MateriPage(
                    kategori: category[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class CardMateri extends StatelessWidget {
  const CardMateri({
    Key? key,
    required this.imageAssets,
    required this.press,
  }) : super(key: key);

  final Function() press;

  final String imageAssets;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: getPropertionateScreenWidht(122),
        width: getPropertionateScreenWidht(154),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          image: DecorationImage(
              image: AssetImage(
                imageAssets,
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ListCover {
  String cover;
  ListCover({required this.cover});
}

List<ListCover> listCover = [
  ListCover(cover: 'assets/bilanganbulat.jpg'),
  ListCover(cover: 'assets/himpunan.jpg'),
  ListCover(cover: 'assets/aljabar.jpg'),
  ListCover(cover: 'assets/plsv.jpg'),
];
