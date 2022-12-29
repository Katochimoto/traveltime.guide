import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function() onTap;
  final bool isSelected;

  const DrawerTile({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: isSelected ? null : Colors.transparent,
          foregroundColor: isSelected
              ? Theme.of(context).textTheme.button?.color
              : Theme.of(context).primaryTextTheme.button?.color,
          shadowColor: Colors.transparent),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null ? Icon(icon, size: 18) : Container(),
          icon != null ? const SizedBox(width: 10) : Container(),
          Text(title),
        ],
      ),
    );
  }
}
