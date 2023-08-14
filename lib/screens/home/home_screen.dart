import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/weather/widgets/home_weather.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';
import 'package:traveltime/widgets/navbar/navbar_search.dart';
import 'package:traveltime/widgets/page_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _content(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: HomeWeather(),
        ),
        // const SizedBox(height: 8.0),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CardSmall(
        //         title: homeCards["Makeup"]['title'],
        //         img: homeCards["Makeup"]['image'],
        //         tap: () {
        //           context
        //               .pushNamed(Routes.article, pathParameters: {'id': '123'});
        //         }),
        //     CardSmall(
        //         title: homeCards["Coffee"]['title'],
        //         img: homeCards["Coffee"]['image'],
        //         tap: () {
        //           context
        //               .pushNamed(Routes.article, pathParameters: {'id': '123'});
        //         })
        //   ],
        // ),
        // const SizedBox(height: 8.0),
        // CardHorizontal(
        //     title: homeCards["Fashion"]['title'],
        //     img: homeCards["Fashion"]['image'],
        //     tap: () {
        //       context.pushNamed(Routes.article, pathParameters: {'id': '123'});
        //     }),
        // const SizedBox(height: 8.0),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 32.0),
        //   child: CardSquare(
        //       title: homeCards["Argon"]['title'],
        //       img: homeCards["Argon"]['image'],
        //       tap: () {
        //         context
        //             .pushNamed(Routes.article, pathParameters: {'id': '123'});
        //       }),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: AppLocalizations.of(context)!.discoverTitle,
        search: const NavbarSearch(),
        categories: NavbarCategories(
          items: [
            NavbarCategorieButton(
              icon: Icons.map,
              title: 'Map',
              onPressed: () {
                context.goNamed(Routes.map);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.event,
              title: 'Events',
              onPressed: () {
                context.goNamed(Routes.events);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.filter_drama,
              title: 'Weather',
              onPressed: () {
                context.goNamed(Routes.weather);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.hiking,
              title: 'Activities',
              onPressed: () {
                context.goNamed(Routes.activities);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.route,
              title: 'Routes',
              onPressed: () {
                context.goNamed(Routes.routes);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.set_meal_sharp,
              title: 'Food',
              onPressed: () {
                context.goNamed(Routes.articles);
              },
            ),
            NavbarCategorieButton(
              icon: Icons.newspaper,
              title: 'News',
              onPressed: () {
                context.goNamed(Routes.articles);
              },
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(currentPage: Routes.discover),
      body: PageLayout(child: _content(context)),
    );
  }
}
