import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class PageLayoutContent extends StatelessWidget {
  final Widget? child;

  const PageLayoutContent({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: UIGap.g2),
        child: child,
      ),
    );
  }
}

class PageLayout extends StatelessWidget {
  final Widget? child;
  final bool scroll;

  const PageLayout({
    super.key,
    this.child,
    this.scroll = true,
  });

  @override
  Widget build(BuildContext context) {
    if (scroll) {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: PageLayoutContent(child: child),
            ),
          ),
        ],
      );
    }

    return PageLayoutContent(child: child);

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
