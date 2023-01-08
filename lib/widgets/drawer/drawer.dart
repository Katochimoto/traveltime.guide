import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:traveltime/widgets/drawer/drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  final String currentPage;

  const AppDrawer({super.key, required this.currentPage});

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
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              image: const DecorationImage(
                image: AssetImage("assets/imgs/drawer_bg.jpg"),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
            child: SafeArea(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                          image: AssetImage("assets/imgs/logo3.png"),
                          width: 35,
                          height: 35),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: IconButton(
                            style: IconButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    ?.color),
                            iconSize: 24,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                            }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      DrawerTile(
                          icon: Icons.login,
                          onTap: _launchURL,
                          title: "Login",
                          isSelected:
                              currentPage == "Getting started" ? true : false),
                      Row(
                        children: [
                          Flexible(
                              child: DrawerTile(
                                  icon: Icons.account_circle,
                                  onTap: () {
                                    if (currentPage != Routes.profile) {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.profile);
                                    }
                                  },
                                  title: "Profile",
                                  isSelected: currentPage == Routes.profile
                                      ? true
                                      : false)),
                          DrawerTile(
                              icon: Icons.logout,
                              onTap: _launchURL,
                              isSelected: currentPage == "Getting started"
                                  ? true
                                  : false),
                        ],
                      ),
                      DrawerTile(
                          icon: Icons.dashboard,
                          onTap: () {
                            if (currentPage != Routes.home) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.home);
                            }
                          },
                          title: AppLocalizations.of(context)!.discoverTitle,
                          isSelected:
                              currentPage == Routes.home ? true : false),
                      DrawerTile(
                          icon: Icons.newspaper,
                          onTap: () {
                            if (currentPage != Routes.articles) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.articles);
                            }
                          },
                          title: AppLocalizations.of(context)!.articlesTitle,
                          isSelected:
                              currentPage == Routes.articles ? true : false),
                      DrawerTile(
                          icon: Icons.map,
                          onTap: () {
                            if (currentPage != Routes.components) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.components);
                            }
                          },
                          title: "Map",
                          isSelected:
                              currentPage == Routes.components ? true : false),
                      DrawerTile(
                          icon: Icons.hiking,
                          onTap: () {
                            if (currentPage != Routes.components) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.components);
                            }
                          },
                          title: "Activities",
                          isSelected:
                              currentPage == Routes.components ? true : false),
                      DrawerTile(
                          icon: Icons.route,
                          onTap: () {
                            if (currentPage != Routes.components) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.components);
                            }
                          },
                          title: "Routes",
                          isSelected:
                              currentPage == Routes.components ? true : false),
                      // DrawerTile(
                      //     icon: FontAwesomeIcons.fileInvoice,
                      //     onTap: () {
                      //       if (currentPage != Routes.account) {
                      //         Navigator.pushReplacementNamed(context, Routes.account);
                      //       }
                      //     },
                      //     title: "Account",
                      //     isSelected: currentPage == Routes.account ? true : false),
                      DrawerTile(
                          icon: Icons.settings,
                          onTap: () {
                            if (currentPage != Routes.settings) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.settings);
                            }
                          },
                          title: "Settings",
                          isSelected:
                              currentPage == Routes.settings ? true : false),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Divider(
                      height: 4,
                      thickness: 1,
                      color: Theme.of(context).primaryColorLight,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      DrawerTile(
                          onTap: _launchURL,
                          title: "Support",
                          isSelected:
                              currentPage == "Getting started" ? true : false),
                      DrawerTile(
                          onTap: _launchURL,
                          title: "Get Pro",
                          isSelected:
                              currentPage == "Getting started" ? true : false),
                      DrawerTile(
                          onTap: _launchURL,
                          title: "About",
                          isSelected:
                              currentPage == "Getting started" ? true : false),
                    ],
                  ),
                ),
                // Expanded(
                //     flex: 1,
                //     child: ListView(
                //       physics: const BouncingScrollPhysics(),
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       children: [
                //         DrawerTile(
                //             icon: Icons.login,
                //             onTap: _launchURL,
                //             title: "Login",
                //             isSelected:
                //                 currentPage == "Getting started" ? true : false),
                //         DrawerTile(
                //             onTap: _launchURL,
                //             title: "Support",
                //             isSelected:
                //                 currentPage == "Getting started" ? true : false),
                //         DrawerTile(
                //             onTap: _launchURL,
                //             title: "Gep Pro",
                //             isSelected:
                //                 currentPage == "Getting started" ? true : false),
                //         DrawerTile(
                //             onTap: _launchURL,
                //             title: "About",
                //             isSelected:
                //                 currentPage == "Getting started" ? true : false),
                //       ],
                //     )),
                Container(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "v1.123.1233",
                            style: Theme.of(context).primaryTextTheme.caption,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                " / Privacy",
                                style:
                                    Theme.of(context).primaryTextTheme.caption,
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                " / Terms",
                                style:
                                    Theme.of(context).primaryTextTheme.caption,
                              )),
                        ])),
              ]),
            )));
  }
}
