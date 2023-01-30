import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final void Function() onTap;
  final bool isSelected;

  const DrawerTile({
    super.key,
    this.title = '',
    this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
          backgroundColor:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          foregroundColor: isSelected
              ? Theme.of(context).primaryTextTheme.labelLarge?.color
              : Theme.of(context).primaryTextTheme.labelLarge?.color,
          shadowColor: Colors.transparent),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null ? Icon(icon, size: 18) : Container(),
          icon != null && title!.isNotEmpty
              ? const SizedBox(width: 10)
              : Container(),
          title!.isNotEmpty ? Text(title ?? '') : Container(),
        ],
      ),
    );
  }
}
