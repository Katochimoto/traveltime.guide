import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class PopoverProgress extends StatelessWidget {
  final double width;
  final double height;

  const PopoverProgress({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(UIGap.g3)),
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
