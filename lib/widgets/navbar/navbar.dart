import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:teamtravel/constants/Theme.dart';

// import 'package:teamtravel/screens/trending.dart';
// import 'package:teamtravel/screens/fashion.dart';
// import 'package:teamtravel/screens/notifications.dart';
// import 'package:teamtravel/screens/search.dart';
// import 'package:teamtravel/screens/cart.dart';

import 'package:teamtravel/widgets/input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? categories;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final bool rightOptions;
  final List<String> tags;
  final void Function(String)? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final void Function(String)? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  const Navbar(
      {this.title = "Home",
      this.tags = const [],
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

  final double _prefferedHeight = UINavbar.hPreffered;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  String activeTag = '';

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    if (widget.tags.isNotEmpty) {
      activeTag = widget.tags[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.isEmpty ? false : true);

    double height = UINavbar.hMenu;
    if (widget.searchBar) {
      height += UINavbar.hSearch;
    }
    if (widget.searchBar && widget.categories != null) {
      height += UIGap.g1;
    }
    if (widget.categories != null) {
      height += UINavbar.hCategories;
    }
    if (tagsExist && widget.categories != null) {
      height += UIGap.g1;
    }
    if (tagsExist) {
      height += UINavbar.hTags;
    }

    return Container(
        height: height,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
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
                        //         !widget.backButton
                        //             ? Icons.menu
                        //             : Icons.arrow_back_ios,
                        //         color: !widget.transparent
                        //             ? (widget.bgColor == NowUIColors.white
                        //                 ? NowUIColors.text
                        //                 : NowUIColors.white)
                        //             : (widget.reverseTextcolor
                        //                 ? NowUIColors.text
                        //                 : NowUIColors.white),
                        //         size: 24.0),
                        //     onPressed: () {
                        //       if (!widget.backButton)
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
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == NowUIColors.white
                                        ? NowUIColors.text
                                        : NowUIColors.white)
                                    : (widget.reverseTextcolor
                                        ? NowUIColors.text
                                        : NowUIColors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                    if (widget.rightOptions)
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
                                    color: !widget.transparent
                                        ? (widget.bgColor == NowUIColors.white
                                            ? NowUIColors.text
                                            : NowUIColors.white)
                                        : (widget.reverseTextcolor
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
                                    color: !widget.transparent
                                        ? (widget.bgColor == NowUIColors.white
                                            ? NowUIColors.text
                                            : NowUIColors.white)
                                        : (widget.reverseTextcolor
                                            ? NowUIColors.text
                                            : NowUIColors.white),
                                    size: 22.0),
                                onPressed: null),
                          ),
                        ],
                      )
                  ],
                ),
                if (widget.searchBar)
                  SizedBox(
                      height: UINavbar.hSearch,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: UIGap.g0, horizontal: UIGap.g2),
                        child: Input(
                            placeholder: "What are you looking for?",
                            controller: widget.searchController,
                            onChanged: widget.searchOnChanged,
                            autofocus: widget.searchAutofocus,
                            suffixIcon: const Icon(
                              Icons.zoom_in,
                              color: NowUIColors.time,
                              size: 20,
                            ),
                            onTap: () {
                              // if (!widget.isOnSearch)
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Search()));
                            }),
                      )),
                ...(widget.categories != null && widget.searchBar
                    ? [const SizedBox(height: UIGap.g1)]
                    : []),
                ...(widget.categories != null
                    ? [widget.categories ?? const SizedBox()]
                    : []),
                ...(widget.categories != null && tagsExist
                    ? [const SizedBox(height: UIGap.g1)]
                    : []),
                if (tagsExist)
                  SizedBox(
                    height: UINavbar.hTags,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tags.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (activeTag != widget.tags[index]) {
                              setState(() => activeTag = widget.tags[index]);
                              _scrollController.scrollTo(
                                  index:
                                      index == widget.tags.length - 1 ? 1 : 0,
                                  duration: const Duration(milliseconds: 420),
                                  curve: Curves.easeIn);
                              if (widget.getCurrentPage != null) {
                                widget.getCurrentPage!(activeTag);
                              }
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 46 : 8, right: 8),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 20, right: 20),
                              // width: 90,
                              decoration: BoxDecoration(
                                  color: activeTag == widget.tags[index]
                                      ? NowUIColors.info
                                      : NowUIColors.tabs,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(54.0))),
                              child: Center(
                                child: Text(widget.tags[index],
                                    style: TextStyle(
                                        color: activeTag == widget.tags[index]
                                            ? NowUIColors.white
                                            : NowUIColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0)),
                              )),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
