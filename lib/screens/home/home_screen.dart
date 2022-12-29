import 'package:flutter/material.dart';

import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/bottom_navbar.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/card-horizontal.dart';
import 'package:traveltime/widgets/card-small.dart';
import 'package:traveltime/widgets/card-square.dart';
import 'package:traveltime/widgets/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';
import 'package:traveltime/widgets/navbar/navbar_search.dart';

// import 'package:traveltime/screens/componentsduct.dart';

final Map<String, dynamic> homeCards = {
  "Ice Cream": {
    "title": "Society has put up so many boundaries",
    "image":
        "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
        "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Many limitations on what’s right",
    "image":
        "https://raw.githubusercontent.com/creativetimofficial/public-assets/master/now-ui-pro-react-native/bg40.jpg"
  },
  "Fashion": {
    "title": "Why would anyone pick blue over?",
    "image":
        "https://images.unsplash.com/photo-1536686763189-829249e085ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=705&q=80"
  },
  "Argon": {
    "title": "Pink is obviously a better color",
    "image":
        "https://raw.githubusercontent.com/creativetimofficial/public-assets/master/now-ui-pro-react-native/componentsject21.jpg"
  }
};

@immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final GlobalKey _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Navbar(
          title: "Home",
          search: NavbarSearch(),
          categories: NavbarCategories(),
        ),
        backgroundColor: NowUIColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: const NowDrawer(currentPage: Routes.home),
        bottomNavigationBar: BottomNavbar(),
        body: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CardHorizontal(
                      cta: "View article",
                      title: homeCards["Ice Cream"]['title'],
                      img: homeCards["Ice Cream"]['image'],
                      tap: () {
                        Navigator.popAndPushNamed(context, '/components');
                      }),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "View article",
                        title: homeCards["Makeup"]['title'],
                        img: homeCards["Makeup"]['image'],
                        tap: () {}),
                    CardSmall(
                        cta: "View article",
                        title: homeCards["Coffee"]['title'],
                        img: homeCards["Coffee"]['image'],
                        tap: () {
                          Navigator.popAndPushNamed(context, '/components');
                        })
                  ],
                ),
                const SizedBox(height: 8.0),
                CardHorizontal(
                    cta: "View article",
                    title: homeCards["Fashion"]['title'],
                    img: homeCards["Fashion"]['image'],
                    tap: () {
                      Navigator.popAndPushNamed(context, '/components');
                    }),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardSquare(
                      cta: "View article",
                      title: homeCards["Argon"]['title'],
                      img: homeCards["Argon"]['image'],
                      tap: () {
                        Navigator.popAndPushNamed(context, '/components');
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
