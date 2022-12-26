import 'package:flutter/material.dart';
import 'package:teamtravel/screens/articles/articles_screen.dart';
import 'package:teamtravel/screens/components/components_screen.dart';
import 'package:teamtravel/screens/home/home_screen.dart';
import 'package:teamtravel/screens/profile/profile_screen.dart';
import 'package:teamtravel/screens/register/register_screen.dart';
import 'package:teamtravel/screens/settings/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:teamtravel/constants/Theme.dart';

import 'package:teamtravel/widgets/drawer-tile.dart';

class NowDrawer extends StatelessWidget {
  final String currentPage;

  const NowDrawer({required this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: NowUIColors.primary,
      child: Column(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Image.asset("assets/imgs/now-logo.png"),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                          icon: Icon(Icons.menu,
                              color: NowUIColors.white.withOpacity(0.82),
                              size: 24.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.only(top: 36, left: 8, right: 16),
            children: [
              DrawerTile(
                  icon: FontAwesomeIcons.house,
                  onTap: () {
                    if (currentPage != HomeScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.primary,
                  title: "Home",
                  isSelected:
                      currentPage == HomeScreen.routeName ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.dharmachakra,
                  onTap: () {
                    if (currentPage != ComponentsScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, ComponentsScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.error,
                  title: "Components",
                  isSelected:
                      currentPage == ComponentsScreen.routeName ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.newspaper,
                  onTap: () {
                    if (currentPage != ArticlesScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, ArticlesScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.primary,
                  title: "Articles",
                  isSelected:
                      currentPage == ArticlesScreen.routeName ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    if (currentPage != ProfileScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, ProfileScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.warning,
                  title: "Profile",
                  isSelected:
                      currentPage == ProfileScreen.routeName ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.fileInvoice,
                  onTap: () {
                    if (currentPage != RegisterScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.info,
                  title: "Account",
                  isSelected:
                      currentPage == RegisterScreen.routeName ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.cog,
                  onTap: () {
                    if (currentPage != SettingsScreen.routeName) {
                      Navigator.pushReplacementNamed(
                          context, SettingsScreen.routeName);
                    }
                  },
                  iconColor: NowUIColors.success,
                  title: "Settings",
                  isSelected:
                      currentPage == SettingsScreen.routeName ? true : false),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                      height: 4,
                      thickness: 0,
                      color: NowUIColors.white.withOpacity(0.8)),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: NowUIColors.white.withOpacity(0.8),
                          fontSize: 13,
                        )),
                  ),
                  DrawerTile(
                      icon: FontAwesomeIcons.satellite,
                      onTap: _launchURL,
                      iconColor: NowUIColors.muted,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
