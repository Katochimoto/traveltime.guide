import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/_theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/navbar/bottom_navbar.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/widgets/card/card_small.dart';
import 'package:traveltime/widgets/card/card_square.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';
import 'package:traveltime/widgets/navbar/navbar_search.dart';
import 'package:traveltime/widgets/page_layout.dart';

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
        "https://images.unsplash.com/photo-1536686763189-829249e085ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=705&q=80"
  }
};

@immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CardHorizontalContainer(
            tap: () {
              context.pushNamed(Routes.article, pathParameters: {'id': '123'});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: UIGap.g5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(35))),
                        child: Image.network(
                          'https://openweathermap.org/img/wn/10d@2x.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: UIGap.g2),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chon Buri',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '27C',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(width: UIGap.g1),
                              // Transform.rotate(
                              //   angle: 180 * pi / 180,
                              //   child: const Icon(Icons.arrow_right_alt, size: 20),
                              // ),
                              // Text(
                              //   '10m/c',
                              //   style: Theme.of(context).textTheme.bodySmall,
                              // ),
                              Text(
                                'Cloudy',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: IntrinsicColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text('Sat',
                              style: Theme.of(context).textTheme.labelSmall),
                          Image.network(
                            'https://openweathermap.org/img/wn/10d@2x.png',
                            width: 30,
                            height: 30,
                          ),
                          Text('20C',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Sun',
                              style: Theme.of(context).textTheme.labelSmall),
                          Image.network(
                            'https://openweathermap.org/img/wn/10d@2x.png',
                            width: 30,
                            height: 30,
                          ),
                          Text('20C',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Mon',
                              style: Theme.of(context).textTheme.labelSmall),
                          Image.network(
                            'https://openweathermap.org/img/wn/10d@2x.png',
                            width: 30,
                            height: 30,
                          ),
                          Text('20C',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardSmall(
                title: homeCards["Makeup"]['title'],
                img: homeCards["Makeup"]['image'],
                tap: () {
                  context
                      .pushNamed(Routes.article, pathParameters: {'id': '123'});
                }),
            CardSmall(
                title: homeCards["Coffee"]['title'],
                img: homeCards["Coffee"]['image'],
                tap: () {
                  context
                      .pushNamed(Routes.article, pathParameters: {'id': '123'});
                })
          ],
        ),
        const SizedBox(height: 8.0),
        CardHorizontal(
            title: homeCards["Fashion"]['title'],
            img: homeCards["Fashion"]['image'],
            tap: () {
              context.pushNamed(Routes.article, pathParameters: {'id': '123'});
            }),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: CardSquare(
              title: homeCards["Argon"]['title'],
              img: homeCards["Argon"]['image'],
              tap: () {
                context
                    .pushNamed(Routes.article, pathParameters: {'id': '123'});
              }),
        ),
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
                icon: Icons.filter_drama, title: 'Weather', onPressed: () {}),
            NavbarCategorieButton(
              icon: Icons.hiking,
              title: 'Activities',
              onPressed: () {
                context.goNamed(Routes.articles);
              },
            ),
            NavbarCategorieButton(
                icon: Icons.route, title: 'Routes', onPressed: () {}),
            NavbarCategorieButton(
                icon: Icons.change_circle, title: 'Currency', onPressed: () {}),
            NavbarCategorieButton(
                icon: Icons.set_meal_sharp, title: 'Food', onPressed: () {}),
            NavbarCategorieButton(
                icon: Icons.newspaper, title: 'News', onPressed: () {}),
            NavbarCategorieButton(
                icon: Icons.description, title: 'Visa', onPressed: () {}),
            NavbarCategorieButton(
                icon: Icons.coronavirus, title: 'COVID', onPressed: () {}),
          ],
        ),
      ),
      drawer: const AppDrawer(currentPage: Routes.discover),
      bottomNavigationBar: const BottomNavbar(),
      body: PageLayout(child: _content(context)),
    );
  }
}
