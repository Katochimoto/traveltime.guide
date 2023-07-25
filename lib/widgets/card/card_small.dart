import 'package:flutter/material.dart';
import 'package:traveltime/constants/_theme.dart';

class CardSmall extends StatelessWidget {
  final String img;
  final void Function() tap;
  final String title;

  const CardSmall(
      {super.key,
      required this.title,
      this.img = "https://via.placeholder.com/200",
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Card(
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
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: 11,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(UIGap.g2),
                              topRight: Radius.circular(UIGap.g2)),
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
                            style: Theme.of(context).textTheme.bodySmall),
                        // Container(
                        //     padding: const EdgeInsets.only(top: UIGap.g1),
                        //     transform: Matrix4.translationValues(
                        //         -(UIGap.g2), UIGap.g2, UIGap.g0),
                        //     child: TextButton(
                        //       onPressed: tap,
                        //       style: TextButton.styleFrom(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: UIGap.g0, horizontal: UIGap.g2),
                        //           minimumSize: const Size(50, 25),
                        //           tapTargetSize:
                        //               MaterialTapTargetSize.shrinkWrap,
                        //           alignment: Alignment.centerLeft),
                        //       child: Text(cta),
                        //     )),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
