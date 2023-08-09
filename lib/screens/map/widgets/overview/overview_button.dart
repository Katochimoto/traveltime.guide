import 'package:flutter/material.dart';

class OverviewButton extends StatelessWidget {
  const OverviewButton({
    super.key,
    this.active,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final bool? active;
  final String title;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: 25,
          color: active == true ? Colors.tealAccent : Colors.white,
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .merge(Typography.whiteCupertino)
                .bodySmall)
      ],
    );
  }
}
