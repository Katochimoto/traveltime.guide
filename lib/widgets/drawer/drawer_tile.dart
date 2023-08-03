import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    this.title = '',
    this.icon,
    required this.onTap,
    this.isSelected = false,
    this.isSecondary = false,
  });

  final String? title;
  final IconData? icon;
  final void Function() onTap;
  final bool isSelected;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          // minimumSize: isSecondary == true ? Size.fromHeight(20) : null,
          textStyle: isSecondary == true ? const TextStyle(fontSize: 12) : null,
          shape: const StadiumBorder(),
          backgroundColor:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          foregroundColor: isSelected
              ? Theme.of(context)
                  .textTheme
                  .merge(Typography.whiteCupertino)
                  .labelLarge
                  ?.color
              : Theme.of(context)
                  .textTheme
                  .merge(Typography.whiteCupertino)
                  .labelLarge
                  ?.color,
          shadowColor: Colors.transparent),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
          icon != null && title!.isNotEmpty
              ? const SizedBox(width: 10)
              : const SizedBox.shrink(),
          title!.isNotEmpty ? Text(title ?? '') : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
