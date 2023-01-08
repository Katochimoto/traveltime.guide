import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

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
            BoxDecoration(color: Theme.of(context).canvasColor, boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: -15,
              blurRadius: 12,
              offset: const Offset(0, 5))
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
                    Navigator.canPop(context)
                        ? IconButton(
                            iconSize: 24,
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () async {
                              if (!await Navigator.of(context).maybePop()) {
                                Scaffold.of(context).openDrawer();
                              }
                            },
                          )
                        : IconButton(
                            iconSize: 24,
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.notifications_active),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                ),
                ...(search != null ? [Container(child: search)] : []),
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
