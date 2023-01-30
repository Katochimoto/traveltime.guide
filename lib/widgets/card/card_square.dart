import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

class CardSquare extends StatelessWidget {
  final String cta;
  final String img;
  final void Function() tap;
  final String title;

  const CardSquare(
      {super.key,
      this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: null,
      child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          )))),
              SizedBox(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: UIGap.g3, vertical: UIGap.g2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodySmall),
                    Container(
                        padding: const EdgeInsets.only(top: UIGap.g0),
                        transform: Matrix4.translationValues(
                            -(UIGap.g2), UIGap.g1, UIGap.g0),
                        child: TextButton(
                          onPressed: tap,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: UIGap.g2),
                              minimumSize: const Size(50, 25),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          child: Text(cta),
                        )),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
