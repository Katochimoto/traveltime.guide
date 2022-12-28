import 'package:flutter/material.dart';
import 'package:teamtravel/constants/Theme.dart';

// import 'package:teamtravel/screens/trending.dart';
// import 'package:teamtravel/screens/fashion.dart';
// import 'package:teamtravel/screens/notifications.dart';
// import 'package:teamtravel/screens/search.dart';
// import 'package:teamtravel/screens/cart.dart';

import 'package:teamtravel/widgets/input.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? categories;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final bool rightOptions;
  final void Function(String)? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final void Function(String)? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  const Navbar(
      {this.title = "Home",
      this.categories,
      this.transparent = false,
      this.rightOptions = true,
      this.reverseTextcolor = false,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = NowUIColors.white,
      this.searchBar = false});

  @override
  Size get preferredSize => Size.fromHeight(UINavbar.hMenu +
      (searchBar ? UINavbar.hSearch : 0) +
      (categories != null ? UINavbar.hCategories : 0) +
      (searchBar && categories != null ? UIGap.g1 : 0));

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return Container(
        height: preferredSize.height + safePadding,
        decoration: BoxDecoration(
            color: !transparent ? bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !transparent && !noShadow
                      ? NowUIColors.muted
                      : Colors.transparent,
                  spreadRadius: -10,
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
                    Row(
                      children: [
                        // IconButton(
                        //     icon: Icon(
                        //         !backButton
                        //             ? Icons.menu
                        //             : Icons.arrow_back_ios,
                        //         color: !transparent
                        //             ? (bgColor == NowUIColors.white
                        //                 ? NowUIColors.text
                        //                 : NowUIColors.white)
                        //             : (reverseTextcolor
                        //                 ? NowUIColors.text
                        //                 : NowUIColors.white),
                        //         size: 24.0),
                        //     onPressed: () {
                        //       if (!backButton)
                        //         Scaffold.of(context).openDrawer();
                        //       else
                        //         Navigator.pop(context);
                        //     }),
                        ...(Navigator.canPop(context)
                            ? [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: NowUIColors.text, size: 24),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]
                            : [
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      color: NowUIColors.text, size: 24),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ]),
                        Text(title,
                            style: TextStyle(
                                color: !transparent
                                    ? (bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                    if (rightOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Notifications()));
                            },
                            child: IconButton(
                                icon: Icon(Icons.notifications_active,
                                    color: !transparent
                                        ? (bgColor == NowUIColors.white
                                            ? NowUIColors.text
                                            : NowUIColors.white)
                                        : (reverseTextcolor
                                            ? NowUIColors.text
                                            : NowUIColors.white),
                                    size: 22.0),
                                onPressed: null),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Cart()));
                            },
                            child: IconButton(
                                icon: Icon(Icons.shopping_basket,
                                    color: !transparent
                                        ? (bgColor == NowUIColors.white
                                            ? NowUIColors.text
                                            : NowUIColors.white)
                                        : (reverseTextcolor
                                            ? NowUIColors.text
                                            : NowUIColors.white),
                                    size: 22.0),
                                onPressed: null),
                          ),
                        ],
                      )
                  ],
                ),
                if (searchBar)
                  SizedBox(
                      height: UINavbar.hSearch,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: UIGap.g0, horizontal: UIGap.g2),
                        child: Input(
                            placeholder: "What are you looking for?",
                            controller: searchController,
                            onChanged: searchOnChanged,
                            autofocus: searchAutofocus,
                            suffixIcon: const Icon(
                              Icons.zoom_in,
                              color: NowUIColors.time,
                              size: 20,
                            ),
                            onTap: () {
                              // if (!isOnSearch)
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Search()));
                            }),
                      )),
                ...(categories != null && searchBar
                    ? [const SizedBox(height: UIGap.g1)]
                    : []),
                ...(categories != null
                    ? [
                        Container(
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: UIGap.g0, horizontal: UIGap.g0),
                            child: categories)
                      ]
                    : []),
              ],
            ),
          ),
        ));
  }
}
