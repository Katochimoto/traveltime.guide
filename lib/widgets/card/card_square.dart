import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class CardSquare extends StatelessWidget {
  final String img;
  final void Function() tap;
  final String title;

  const CardSquare(
      {super.key,
      required this.title,
      this.img = "https://via.placeholder.com/200",
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: ElevatedButton(
            onPressed: tap,
            style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Theme.of(context).cardColor,
                shadowColor: Theme.of(context).shadowColor,
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(UIGap.g2)))),
            child: SizedBox(
              height: 250,
              width: null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(UIGap.g2),
                                  topRight: Radius.circular(UIGap.g2)),
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
                        Text(title,
                            style: Theme.of(context).textTheme.bodySmall),
                        // Container(
                        //     padding: const EdgeInsets.only(top: UIGap.g0),
                        //     transform: Matrix4.translationValues(
                        //         -(UIGap.g2), UIGap.g1, UIGap.g0),
                        //     child: TextButton(
                        //       onPressed: tap,
                        //       style: TextButton.styleFrom(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 0, horizontal: UIGap.g2),
                        //           minimumSize: const Size(50, 25),
                        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //           alignment: Alignment.centerLeft),
                        //       child: Text(cta),
                        //     )),
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }
}
