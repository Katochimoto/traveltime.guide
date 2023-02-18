import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';

class NavbarCategorieButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onPressed;

  const NavbarCategorieButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        iconSize: 20,
        style: IconButton.styleFrom(
          shadowColor: colors.secondaryContainer,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          foregroundColor: colors.onSecondaryContainer,
          backgroundColor: colors.secondaryContainer,
          disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
          hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
          focusColor: colors.onSecondaryContainer.withOpacity(0.12),
          highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
        ),
      ),
      Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: theme.textTheme.bodySmall,
      ),
    ]);
  }
}

class NavbarCategories extends StatelessWidget {
  const NavbarCategories({super.key, required this.items});

  final List<NavbarCategorieButton> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UINavbar.hCategories,
      child: ListView(
        shrinkWrap: true,
        itemExtent: 65.0,
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }
}
