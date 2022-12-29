import 'package:flutter/material.dart';
import 'package:teamtravel/constants/Theme.dart';

// import 'package:teamtravel/screens/trending.dart';
// import 'package:teamtravel/screens/fashion.dart';
// import 'package:teamtravel/screens/notifications.dart';
// import 'package:teamtravel/screens/search.dart';
// import 'package:teamtravel/screens/cart.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? categories;
  final Widget? search;

  const Navbar({super.key, this.title = "", this.categories, this.search});

  @override
  Size get preferredSize => Size.fromHeight(UINavbar.hMenu +
      (search != null ? UINavbar.hSearch : 0) +
      (categories != null ? UINavbar.hCategories : 0) +
      (search != null && categories != null ? UIGap.g1 : 0));

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return Container(
        height: preferredSize.height + safePadding,
        decoration:
            const BoxDecoration(color: NowUIColors.bgColorNavbar, boxShadow: [
          BoxShadow(
              color: NowUIColors.muted,
              spreadRadius: -10,
              blurRadius: 12,
              offset: Offset(0, 5))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: UIGap.g0, horizontal: UIGap.g2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ...(Navigator.canPop(context)
                            ? [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: NowUIColors.textNavbar, size: 24),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]
                            : [
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      color: NowUIColors.textNavbar, size: 24),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ]),
                        Text(title,
                            style: const TextStyle(
                                color: NowUIColors.textNavbar,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_active,
                              color: NowUIColors.textNavbar, size: 22),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ],
                    )
                  ],
                ),
                if (search != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: UIGap.g0, horizontal: UIGap.g2),
                    child: search,
                  ),
                ...(categories != null && search != null
                    ? [const SizedBox(height: UIGap.g1)]
                    : []),
                ...(categories != null ? [Container(child: categories)] : []),
              ],
            ),
          ),
        ));
  }
}
