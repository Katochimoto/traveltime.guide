import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

class PopoverNotFound extends StatelessWidget {
  final double width;
  final double height;

  const PopoverNotFound({
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
