import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class CardHorizontalContainer extends StatelessWidget {
  const CardHorizontalContainer({
    super.key,
    required this.child,
    required this.tap,
    this.color,
  });

  final Widget child;
  final void Function() tap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ElevatedButton(
        onPressed: tap,
        style: ElevatedButton.styleFrom(
          elevation: 1,
          alignment: Alignment.topLeft,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: color ?? Theme.of(context).cardColor,
          shadowColor: Theme.of(context).shadowColor,
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(UIGap.g2))),
        ),
        child: SizedBox.fromSize(
          size: const Size.fromHeight(130),
          child: child,
        ),
        // child: SizedBox(
        //   height: 130,
        //   child: child,
        // ),
      ),
    );
  }
}

class CardHorizontal extends StatelessWidget {
  const CardHorizontal({
    super.key,
    required this.title,
    required this.tap,
    this.details,
    this.img,
    this.color,
  });

  final String? img;
  final void Function() tap;
  final String title;
  final String? details;
  final Color? color;

  Widget _img(String? img) {
    if (img == null) {
      return const SizedBox();
    }

    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(UIGap.g2),
                bottomLeft: Radius.circular(UIGap.g2)),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardHorizontalContainer(
      color: color,
      tap: tap,
      child: Row(
        children: [
          _img(img),
          Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(UIGap.g2),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    if (details != null)
                      Padding(
                        padding: const EdgeInsets.only(top: UIGap.g1),
                        child: Text(
                          details!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
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
                    //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //           alignment: Alignment.centerLeft),
                    //       child: Text(cta),
                    //     )),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
