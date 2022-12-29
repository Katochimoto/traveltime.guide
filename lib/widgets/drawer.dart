import 'package:flutter/material.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/widgets/drawer_tile.dart';

class NowDrawer extends StatelessWidget {
  final String currentPage;

  const NowDrawer({super.key, required this.currentPage});

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
      child: Column(children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage("assets/imgs/now-logo.png"),
                    width: 24,
                    height: 24),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IconButton(
                      style: IconButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).primaryTextTheme.button?.color),
                      iconSize: 24,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                      }),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.only(left: 8, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.dashboard,
                  onTap: () {
                    if (currentPage != Routes.home) {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    }
                  },
                  title: "Discover",
                  isSelected: currentPage == Routes.home ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.dharmachakra,
                  onTap: () {
                    if (currentPage != Routes.components) {
                      Navigator.pushReplacementNamed(
                          context, Routes.components);
                    }
                  },
                  title: "Components",
                  isSelected: currentPage == Routes.components ? true : false),
              DrawerTile(
                  icon: Icons.newspaper,
                  onTap: () {
                    if (currentPage != Routes.articles) {
                      Navigator.pushReplacementNamed(context, Routes.articles);
                    }
                  },
                  title: "Articles",
                  isSelected: currentPage == Routes.articles ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    if (currentPage != Routes.profile) {
                      Navigator.pushReplacementNamed(context, Routes.profile);
                    }
                  },
                  title: "Profile",
                  isSelected: currentPage == Routes.profile ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.fileInvoice,
                  onTap: () {
                    if (currentPage != Routes.account) {
                      Navigator.pushReplacementNamed(context, Routes.account);
                    }
                  },
                  title: "Account",
                  isSelected: currentPage == Routes.account ? true : false),
              DrawerTile(
                  icon: Icons.settings,
                  onTap: () {
                    if (currentPage != Routes.settings) {
                      Navigator.pushReplacementNamed(context, Routes.settings);
                    }
                  },
                  title: "Settings",
                  isSelected: currentPage == Routes.settings ? true : false),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Divider(
                height: 4,
                thickness: 0,
                color: NowUIColors.white.withOpacity(0.8))),
        Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.only(left: 8, right: 16),
              children: [
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "Login",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "About",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "Support",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "Gep Pro",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "Privacy",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
                DrawerTile(
                    icon: Icons.login,
                    onTap: _launchURL,
                    title: "Terms",
                    isSelected:
                        currentPage == "Getting started" ? true : false),
              ],
            )),
        SafeArea(
          top: false,
          child: Container(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Text(
                "v1.123.1233",
                style: TextStyle(
                  color: NowUIColors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
              )),
        )
      ]),
    ));
  }
}
