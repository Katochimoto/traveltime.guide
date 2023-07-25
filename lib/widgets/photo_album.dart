import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class PhotoAlbum extends StatelessWidget {
  final List<String> imgArray;

  const PhotoAlbum({super.key, required this.imgArray});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(UIGap.g0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: imgArray
              .map((item) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(
                        image: NetworkImage(item), // AssetImage(item),
                        fit: BoxFit.cover,
                      ))))
              .toList()),
    );
  }
}
