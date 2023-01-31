import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/page_layout.dart';

class ArticleController extends ConsumerWidget {
  final int id;

  const ArticleController({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleProvider(id));
    return article.when(
      data: (data) {
        return data == null
            ? const Center(
                child:
                    Image(image: AssetImage('assets/imgs/page_not_found.png')))
            : ArticleDetails(article: data);
      },
      error: (error, stackTrace) {
        return const CircularProgressIndicator();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ArticleDetails extends StatelessWidget {
  final Article article;

  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(article.coverImg!),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          decoration:
                              const BoxDecoration(color: Colors.black45)),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: UIGap.g2,
                              left: UIGap.g3,
                              right: UIGap.g3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                              const SizedBox(height: UIGap.g1),
                              Text("Author",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodySmall),
                              const SizedBox(height: UIGap.g2),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: UIGap.g3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "2K",
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge,
                                        ),
                                        Text("Friends",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodySmall)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("26",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge),
                                        Text("Comments",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodySmall)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("48",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge),
                                        Text("Bookmarks",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodySmall)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Flexible(
                flex: 3,
                child: PageLayout(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: UIGap.g3),
                          child: MarkdownBody(data: article.description),
                        ),
                        // const PhotoAlbum(imgArray: [
                        //   "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                        //   "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                        //   "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80",
                        //   "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80",
                        //   "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80",
                        //   "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80",
                        // ])
                      ]),
                )),
          ],
        ),
      ],
    );
  }
}

class ArticleScreen extends StatelessWidget {
  final int id;

  const ArticleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Navbar(
          isTransparent: true,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: ArticleController(id: id));
  }
}
