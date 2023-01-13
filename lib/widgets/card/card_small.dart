import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

class CardSmall extends StatelessWidget {
  final String cta;
  final String img;
  final void Function() tap;
  final String title;

  const CardSmall(
      {super.key,
      this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 235,
        child: Card(
            elevation: 3,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 11,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                            image: DecorationImage(
                              image: NetworkImage(img),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(UIGap.g3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: Theme.of(context).textTheme.caption),
                          Container(
                              padding: const EdgeInsets.only(top: UIGap.g1),
                              transform: Matrix4.translationValues(
                                  -(UIGap.g2), UIGap.g2, UIGap.g0),
                              child: TextButton(
                                onPressed: tap,
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: UIGap.g0,
                                        horizontal: UIGap.g2),
                                    minimumSize: const Size(50, 25),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                child: Text(cta),
                              )),
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
