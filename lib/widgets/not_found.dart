import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.srgbToLinearGamma(),
                fit: BoxFit.contain,
                image: AssetImage('assets/imgs/not_found.png'),
              ),
            ),
          ),
          if (text != null)
            Text(
              text!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }
}
