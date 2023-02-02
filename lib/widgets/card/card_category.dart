import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String img;
  final void Function() tap;
  final String title;

  const CardCategory(
      {super.key,
      this.title = "Placeholder Title",
      this.img = "https://via.placeholder.com/250",
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: null,
      child: Card(
          elevation: 0.4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Stack(children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ))),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
            Center(
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .merge(Typography.whiteCupertino)
                      .titleLarge),
            )
          ])),
    );
  }
}
