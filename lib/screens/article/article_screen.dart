import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/page_layout.dart';
import 'package:traveltime/widgets/photo-album.dart';

List<String> imgArray = [
  "assets/imgs/album-1.jpg",
  "assets/imgs/album-2.jpg",
  "assets/imgs/album-3.jpg",
  "assets/imgs/album-4.jpg",
  "assets/imgs/album-5.jpg",
  "assets/imgs/album-6.jpg"
];

@immutable
class ArticleScreen extends StatelessWidget {
  final String id;

  const ArticleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Navbar(
          isTransparent: true,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/imgs/bg-profile.png"),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
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
                                    "Article 1",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(height: UIGap.g1),
                                  Text("Author",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .caption),
                                  const SizedBox(height: UIGap.g2),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: UIGap.g3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                                    .caption)
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
                                                    .caption)
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
                                                    .caption)
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
                      child: Column(children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: UIGap.g3),
                          child: Text(
                            "An artist of considerable range, Ryan - the name taken by Meblourne-raised, Brooklyn-based Nick Murphy - writes, performs and records all of his own music.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        PhotoAlbum(imgArray: imgArray)
                      ]),
                    )),
              ],
            ),
          ],
        ));
  }
}
