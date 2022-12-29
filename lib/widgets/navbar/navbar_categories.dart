import 'package:flutter/material.dart';
import 'package:teamtravel/constants/Theme.dart';

class NavbarCategorieButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const NavbarCategorieButton(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(children: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
        iconSize: 20,
        padding: const EdgeInsets.all(10),
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
      Text(title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: NowUIColors.text, fontSize: 12.0)),
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
        children: const <Widget>[
          NavbarCategorieButton(icon: Icons.map, title: 'Map'),
          NavbarCategorieButton(icon: Icons.filter_drama, title: 'Weather'),
          NavbarCategorieButton(icon: Icons.hiking, title: 'Activities'),
          NavbarCategorieButton(icon: Icons.route, title: 'Routes'),
          NavbarCategorieButton(icon: Icons.change_circle, title: 'Currency'),
          NavbarCategorieButton(icon: Icons.newspaper, title: 'News'),
          NavbarCategorieButton(icon: Icons.description, title: 'Visa'),
        ],
      ),
    );
  }
}
