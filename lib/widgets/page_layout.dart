import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

@immutable
class PageLayout extends StatelessWidget {
  final Widget? child;

  const PageLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: UIGap.g2),
                    child: child,
                  ))),
        ),
      ],
    );

    // return SingleChildScrollView(
    //     child: Center(
    //         child: ConstrainedBox(
    //             constraints: const BoxConstraints(maxWidth: 1200),
    //             child: Container(
    //               padding: const EdgeInsets.symmetric(horizontal: UIGap.g2),
    //               child: child,
    //             ))));
  }
}
