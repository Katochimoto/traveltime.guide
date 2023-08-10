import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/drawer/app_details.dart';
import 'package:traveltime/widgets/drawer/drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.currentPage});

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              image: const DecorationImage(
                image: AssetImage('assets/imgs/drawer_bg.jpg'),
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
                          image: AssetImage('assets/imgs/logo.png'),
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
                      // DrawerTile(
                      //     icon: Icons.login,
                      //     onTap: _launchURL,
                      //     title: "Login",
                      //     isSelected:
                      //         currentPage == "Getting started" ? true : false),
                      Row(
                        children: [
                          Flexible(
                            child: DrawerTile(
                              icon: Icons.account_circle,
                              onTap: () {
                                context.goNamed(Routes.profile);
                              },
                              title: "Profile",
                              isSelected:
                                  currentPage == Routes.profile ? true : false,
                            ),
                          ),
                          DrawerTile(
                            icon: Icons.logout,
                            onTap: () {},
                            isSelected:
                                currentPage == "Getting started" ? true : false,
                          ),
                        ],
                      ),
                      DrawerTile(
                        icon: Icons.dashboard,
                        onTap: () {
                          context.goNamed(Routes.discover);
                        },
                        title: AppLocalizations.of(context)!.discoverTitle,
                        isSelected:
                            currentPage == Routes.discover ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.newspaper,
                        onTap: () {
                          context.goNamed(Routes.articles);
                        },
                        title: AppLocalizations.of(context)!.articlesTitle,
                        isSelected:
                            currentPage == Routes.articles ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.event,
                        onTap: () {
                          context.goNamed(Routes.events);
                        },
                        title: AppLocalizations.of(context)!.eventsTitle,
                        isSelected: currentPage == Routes.events ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.map,
                        onTap: () {
                          context.goNamed(Routes.map);
                        },
                        title: "Map",
                        isSelected: currentPage == Routes.map ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.hiking,
                        onTap: () {
                          context.goNamed(Routes.activities);
                        },
                        title: "Activities",
                        isSelected:
                            currentPage == Routes.activities ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.route,
                        onTap: () {
                          context.goNamed(Routes.routes);
                        },
                        title: "Routes",
                        isSelected: currentPage == Routes.routes ? true : false,
                      ),
                      DrawerTile(
                        icon: Icons.settings,
                        onTap: () {
                          context.goNamed(Routes.settings);
                        },
                        title: "Settings",
                        isSelected:
                            currentPage == Routes.settings ? true : false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      DrawerTile(
                        isSecondary: true,
                        onTap: () {
                          context.goNamed(Routes.about);
                        },
                        title: "About",
                        isSelected: currentPage == Routes.about ? true : false,
                      ),
                      DrawerTile(
                        isSecondary: true,
                        onTap: () {
                          context.goNamed(Routes.disclaimer);
                        },
                        title: "Disclaimer",
                        isSelected:
                            currentPage == Routes.disclaimer ? true : false,
                      ),
                      DrawerTile(
                        isSecondary: true,
                        onTap: () {
                          context.goNamed(Routes.policy);
                        },
                        title: "Privacy Policy",
                        isSelected: currentPage == Routes.policy ? true : false,
                      ),
                      DrawerTile(
                        isSecondary: true,
                        onTap: () {
                          context.goNamed(Routes.terms);
                        },
                        title: "Terms and Conditions",
                        isSelected: currentPage == Routes.terms ? true : false,
                      ),
                    ],
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppDetails(),
                        ])),
              ]),
            )));
  }
}
