import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.srgbToLinearGamma(),
              fit: BoxFit.contain,
              image: AssetImage('assets/imgs/not_found.png'),
            ),
          )),
    );
  }
}
