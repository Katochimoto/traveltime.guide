import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/card-horizontal.dart';
import 'package:traveltime/widgets/card-small.dart';
import 'package:traveltime/widgets/card-square.dart';
import 'package:traveltime/widgets/card-category.dart';
import 'package:traveltime/widgets/slider-product.dart';
import 'package:traveltime/widgets/page_layout.dart';

final Map<String, dynamic> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
        "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
        "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
        "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
        "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
  "Music": {
    "title": "View article",
    "image":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img":
            "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
        "title": "Painting Studio",
        "description":
            "You need a creative space ready for your art? We got that covered.",
        "price": "\$125",
      },
      {
        "img":
            "https://images.unsplash.com/photo-1500628550463-c8881a54d4d4?fit=crop&w=2698&q=80",
        "title": "Art Gallery",
        "description":
            "Don't forget to visit one of the coolest art galleries in town.",
        "price": "\$200",
      },
      {
        "img":
            "https://images.unsplash.com/photo-1496680392913-a0417ec1a0ad?fit=crop&w=2700&q=80",
        "title": "Video Services",
        "description":
            "Some of the best music video services someone could have for the lowest prices.",
        "price": "\$300",
      },
    ],
    "suggestions": [
      {
        "img":
            "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
            "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};

@immutable
class ArticleScreen extends StatelessWidget {
  final String id;

  const ArticleScreen({super.key, required this.id});

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UIGap.g4),
        Text("Cards", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: UIGap.g2),
        CardHorizontal(
            cta: "View article",
            title: articlesCards["Ice Cream"]['title'],
            img: articlesCards["Ice Cream"]['image'],
            tap: () {
              context.goNamed(Routes.components);
            }),
        const SizedBox(height: 8.0),
        Row(
          children: [
            CardSmall(
                cta: "View article",
                title: articlesCards["Makeup"]['title'],
                img: articlesCards["Makeup"]['image'],
                tap: () {
                  context.goNamed(Routes.components);
                }),
            CardSmall(
                cta: "View article",
                title: articlesCards["Coffee"]['title'],
                img: articlesCards["Coffee"]['image'],
                tap: () {
                  context.goNamed(Routes.components);
                })
          ],
        ),
        const SizedBox(height: 8.0),
        CardHorizontal(
            cta: "View article",
            title: articlesCards["Fashion"]['title'],
            img: articlesCards["Fashion"]['image'],
            tap: () {
              context.goNamed(Routes.components);
            }),
        const SizedBox(height: 8.0),
        CardSquare(
            cta: "View article",
            title: articlesCards["Argon"]['title'],
            img: articlesCards["Argon"]['image'],
            tap: () {
              context.goNamed(Routes.components);
            }),
        CardCategory(
            tap: () {
              context.goNamed(Routes.components);
            },
            title: articlesCards["Music"]["title"],
            img: articlesCards["Music"]["image"]),
        const SizedBox(height: UIGap.g4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Album",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: UIGap.g2),
                  minimumSize: const Size(50, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              child: const Text("View All"),
            ),
            // Text("View All", style: Theme.of(context).textTheme.button)
          ],
        ),
        const SizedBox(height: UIGap.g2),
        SizedBox(
          height: 250,
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.symmetric(
                  horizontal: UIGap.g0, vertical: UIGap.g0),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                          fit: BoxFit.cover),
                    )),
                Container(
                    decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                      fit: BoxFit.cover),
                )),
                Container(
                    decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                      fit: BoxFit.cover),
                )),
                Container(
                    decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                      fit: BoxFit.cover),
                )),
                Container(
                    decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                      fit: BoxFit.cover),
                )),
                Container(
                    decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                      fit: BoxFit.cover),
                )),
              ]),
        ),
        const SizedBox(height: UIGap.g4),
        ProductCarousel(imgArray: articlesCards["Music"]["products"]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'wqe', // AppLocalizations.of(context)!.articlesTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: PageLayout(child: _content(context)));
  }
}