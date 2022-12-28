import 'package:flutter/material.dart';
import 'package:teamtravel/constants/Theme.dart';

class NavbarCategorieButton extends StatelessWidget {
  const NavbarCategorieButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(children: [
      IconButton(
        icon: const Icon(Icons.filter_drama),
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
      const Text("Visa",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: NowUIColors.text, fontSize: 10.0)),
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
        itemExtent: 60.0,
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          NavbarCategorieButton(),
          // const SizedBox(width: 10),
          // Container(
          //   color: NowUIColors.text,
          //   height: 25,
          //   width: 1,
          // ),
        ],
      ),
    );
  }
}
