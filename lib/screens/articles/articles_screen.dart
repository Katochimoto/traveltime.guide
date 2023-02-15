import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/widgets/not_found.dart';
// import 'package:traveltime/widgets/card/card_small.dart';
// import 'package:traveltime/widgets/card/card_square.dart';
// import 'package:traveltime/widgets/card/card_category.dart';
// import 'package:traveltime/widgets/photo_album.dart';
// import 'package:traveltime/widgets/slider_product.dart';
import 'package:traveltime/widgets/page_layout.dart';

class ArticlesList extends ConsumerWidget {
  const ArticlesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider).value ?? [];

    if (articles.isEmpty) {
      return const NotFound();
    }

    return ListView.builder(
      itemCount: articles.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        final article = articles[idx];
        return CardHorizontal(
            title: article.title,
            details: article.intro,
            img: article.logoImg,
            tap: () {
              context.pushNamed(Routes.article,
                  params: {'id': article.isarId.toString()});
            });
      },
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     const SizedBox(height: UIGap.g2),
    //     for (final article in articles)
    //       CardHorizontal(
    //           title: article.title,
    //           img: article.logoImg,
    //           tap: () {
    //             context.pushNamed(Routes.article,
    //                 params: {'id': article.id.toString()});
    //           }),
    //   ],
    // );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(height: UIGap.g2),
    //     ...articles
    //         .map((article) => CardHorizontal(
    //             cta: "View article",
    //             title: article.title,
    //             img: article.logo,
    //             tap: () {
    //               context.pushNamed(Routes.article, params: {'id': '123'});
    //             }))
    //         .toList(),
    //     const SizedBox(height: UIGap.g4),
    //     Text("Cards", style: Theme.of(context).textTheme.titleLarge),
    //     const SizedBox(height: UIGap.g2),
    //     CardHorizontal(
    //         cta: "View article",
    //         title: articlesCards["Ice Cream"]['title'],
    //         img: articlesCards["Ice Cream"]['image'],
    //         tap: () {
    //           context.pushNamed(Routes.article, params: {'id': '123'});
    //         }),
    //     const SizedBox(height: 8.0),
    //     Row(
    //       children: [
    //         CardSmall(
    //             cta: "View article",
    //             title: articlesCards["Makeup"]['title'],
    //             img: articlesCards["Makeup"]['image'],
    //             tap: () {
    //               context.pushNamed(Routes.article, params: {'id': '123'});
    //             }),
    //         CardSmall(
    //             cta: "View article",
    //             title: articlesCards["Coffee"]['title'],
    //             img: articlesCards["Coffee"]['image'],
    //             tap: () {
    //               context.pushNamed(Routes.article, params: {'id': '123'});
    //             })
    //       ],
    //     ),
    //     const SizedBox(height: 8.0),
    //     CardHorizontal(
    //         cta: "View article",
    //         title: articlesCards["Fashion"]['title'],
    //         img: articlesCards["Fashion"]['image'],
    //         tap: () {
    //           context.pushNamed(Routes.article, params: {'id': '123'});
    //         }),
    //     const SizedBox(height: 8.0),
    //     CardSquare(
    //         cta: "View article",
    //         title: articlesCards["Argon"]['title'],
    //         img: articlesCards["Argon"]['image'],
    //         tap: () {
    //           context.pushNamed(Routes.article, params: {'id': '123'});
    //         }),
    //     CardCategory(
    //         tap: () {
    //           context.pushNamed(Routes.article, params: {'id': '123'});
    //         },
    //         title: articlesCards["Music"]["title"],
    //         img: articlesCards["Music"]["image"]),
    //     const SizedBox(height: UIGap.g4),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "Album",
    //           style: Theme.of(context).textTheme.titleLarge,
    //         ),
    //         TextButton(
    //           onPressed: () {},
    //           style: TextButton.styleFrom(
    //               padding: const EdgeInsets.symmetric(
    //                   vertical: 0, horizontal: UIGap.g2),
    //               minimumSize: const Size(50, 25),
    //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //               alignment: Alignment.centerLeft),
    //           child: const Text("View All"),
    //         ),
    //         // Text("View All", style: Theme.of(context).textTheme.labelLarge)
    //       ],
    //     ),
    //     const SizedBox(height: UIGap.g2),
    //     const PhotoAlbum(
    //       imgArray: [
    //         "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
    //         "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
    //         "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80",
    //         "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80",
    //         "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80",
    //         "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80",
    //       ],
    //     ),
    //     const SizedBox(height: UIGap.g4),
    //     ProductCarousel(imgArray: articlesCards["Music"]["products"]),
    //   ],
    // );
  }
}

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: AppLocalizations.of(context)!.articlesTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: const PageLayout(
          scroll: false,
          child: ArticlesList(),
        ));
  }
}
