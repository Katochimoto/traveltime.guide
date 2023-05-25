import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/Theme.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? categories;
  final Widget? search;
  final bool isTransparent;

  const Navbar(
      {super.key,
      this.title = "",
      this.categories,
      this.search,
      this.isTransparent = false});

  @override
  Size get preferredSize => Size.fromHeight(UINavbar.hMenu +
      (search != null ? UINavbar.hSearch : 0) +
      (categories != null ? UINavbar.hCategories : 0) +
      (search != null && categories != null ? UIGap.g1 : 0));

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    final navigator = Navigator.of(context);
    final scaffold = Scaffold.of(context);
    return Container(
        height: preferredSize.height + safePadding,
        decoration: BoxDecoration(
            color: isTransparent
                ? Colors.transparent
                : Theme.of(context).canvasColor,
            boxShadow: isTransparent
                ? []
                : [
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
                    context.canPop()
                        ? IconButton(
                            style: isTransparent
                                ? IconButton.styleFrom(
                                    elevation: 3,
                                    shadowColor: Theme.of(context).shadowColor,
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                  )
                                : null,
                            iconSize: 24,
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () async {
                              if (!await navigator.maybePop()) {
                                scaffold.openDrawer();
                              }
                            },
                          )
                        : IconButton(
                            style: isTransparent
                                ? IconButton.styleFrom(
                                    elevation: 3,
                                    shadowColor: Theme.of(context).shadowColor,
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                  )
                                : null,
                            iconSize: 24,
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              scaffold.openDrawer();
                            },
                          ),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      style: isTransparent
                          ? IconButton.styleFrom(
                              elevation: 3,
                              shadowColor: Theme.of(context).shadowColor,
                              backgroundColor: Theme.of(context).canvasColor,
                            )
                          : null,
                      iconSize: 24,
                      icon: const Icon(Icons.notifications_active),
                      onPressed: () {
                        scaffold.openDrawer();
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
