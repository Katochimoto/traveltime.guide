import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                          image: AssetImage("assets/imgs/logo.png"),
                          width: 35,
                          height: 35),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: IconButton(
                            style: IconButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .textTheme
                                    .merge(Typography.whiteCupertino)
                                    .labelLarge
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
                                    context.goNamed(Routes.profile);
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
                            context.goNamed(Routes.discover);
                          },
                          title: AppLocalizations.of(context)!.discoverTitle,
                          isSelected:
                              currentPage == Routes.discover ? true : false),
                      DrawerTile(
                          icon: Icons.newspaper,
                          onTap: () {
                            context.goNamed(Routes.articles);
                          },
                          title: AppLocalizations.of(context)!.articlesTitle,
                          isSelected:
                              currentPage == Routes.articles ? true : false),
                      DrawerTile(
                          icon: Icons.event,
                          onTap: () {
                            context.goNamed(Routes.events);
                          },
                          title: AppLocalizations.of(context)!.eventsTitle,
                          isSelected:
                              currentPage == Routes.events ? true : false),
                      DrawerTile(
                          icon: Icons.map,
                          onTap: () {
                            context.goNamed(Routes.map);
                          },
                          title: "Map",
                          isSelected: currentPage == Routes.map ? true : false),
                      DrawerTile(
                          icon: Icons.hiking,
                          onTap: () {
                            context.goNamed(Routes.components);
                          },
                          title: "Activities",
                          isSelected:
                              currentPage == Routes.components ? true : false),
                      DrawerTile(
                          icon: Icons.route,
                          onTap: () {
                            context.goNamed(Routes.components);
                          },
                          title: "Routes",
                          isSelected:
                              currentPage == Routes.components ? true : false),
                      // DrawerTile(
                      //     icon: FontAwesomeIcons.fileInvoice,
                      //     onTap: () {
                      //       if (currentPage != Routes.account) {
                      //         context.goNamed(Routes.account);
                      //       }
                      //     },
                      //     title: "Account",
                      //     isSelected: currentPage == Routes.account ? true : false),
                      DrawerTile(
                          icon: Icons.settings,
                          onTap: () {
                            context.goNamed(Routes.settings);
                          },
                          title: "Settings",
                          isSelected:
                              currentPage == Routes.settings ? true : false),
                    ],
                  ),
                ),
                // Padding(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //     child: Divider(
                //       height: 4,
                //       thickness: 1,
                //       color: Theme.of(context).primaryColorLight,
                //     )),
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

                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "v1.123.1233",
                            style: Theme.of(context)
                                .textTheme
                                .merge(Typography.whiteCupertino)
                                .bodySmall,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                " / Privacy",
                                style: Theme.of(context)
                                    .textTheme
                                    .merge(Typography.whiteCupertino)
                                    .bodySmall,
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                " / Terms",
                                style: Theme.of(context)
                                    .textTheme
                                    .merge(Typography.whiteCupertino)
                                    .bodySmall,
                              )),
                        ])),
              ]),
            )));
  }
}
