import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';

class PopoverNotFound extends StatelessWidget {
  const PopoverNotFound({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

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
          image: const DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            fit: BoxFit.contain,
            image: AssetImage('assets/imgs/not_found.png'),
          ),
        ),
      ),
    );
  }
}
