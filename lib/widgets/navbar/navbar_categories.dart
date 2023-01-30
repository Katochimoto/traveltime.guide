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
          backgroundColor: colors.secondaryContainer.withOpacity(0.5),
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

@immutable
class NavbarCategories extends StatelessWidget {
  const NavbarCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UINavbar.hCategories,
      child: ListView(
        shrinkWrap: true,
        itemExtent: 65.0,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          NavbarCategorieButton(
            icon: Icons.map,
            title: 'Map',
            onPressed: () {
              context.goNamed(Routes.map);
            },
          ),
          NavbarCategorieButton(
              icon: Icons.filter_drama, title: 'Weather', onPressed: () {}),
          NavbarCategorieButton(
            icon: Icons.hiking,
            title: 'Activities',
            onPressed: () {
              context.goNamed(Routes.articles);
            },
          ),
          NavbarCategorieButton(
              icon: Icons.route, title: 'Routes', onPressed: () {}),
          NavbarCategorieButton(
              icon: Icons.change_circle, title: 'Currency', onPressed: () {}),
          NavbarCategorieButton(
              icon: Icons.set_meal_sharp, title: 'Food', onPressed: () {}),
          NavbarCategorieButton(
              icon: Icons.newspaper, title: 'News', onPressed: () {}),
          NavbarCategorieButton(
              icon: Icons.description, title: 'Visa', onPressed: () {}),
          NavbarCategorieButton(
              icon: Icons.coronavirus, title: 'COVID', onPressed: () {}),
        ],
      ),
    );
  }
}
