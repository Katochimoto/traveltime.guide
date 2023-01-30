import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/page_layout.dart';
import 'package:traveltime/widgets/photo_album.dart';

@immutable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Navbar(
          isTransparent: true,
        ),
        drawer: const AppDrawer(currentPage: Routes.profile),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/imgs/profile-img.jpg"),
                                      radius: 45.0),
                                  const SizedBox(height: UIGap.g3),
                                  Text(
                                    "Ryan Scheinder",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(height: UIGap.g1),
                                  Text("Photographer",
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
                      child: Column(children: [
                        const SizedBox(height: UIGap.g3),
                        Text("About me",
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: UIGap.g3),
                        Text(
                          "An artist of considerable range, Ryan - the name taken by Meblourne-raised, Brooklyn-based Nick Murphy - writes, performs and records all of his own music.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: UIGap.g3),
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: const Text("View All"),
                            ),
                          ],
                        ),
                        const SizedBox(height: UIGap.g2),
                        const PhotoAlbum(imgArray: [
                          "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                          "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                          "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80",
                          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80",
                          "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80",
                          "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80",
                        ])
                      ]),
                    )),
              ],
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 0.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(right: 8.0),
            //           child: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //                 shape: const StadiumBorder()),
            //             onPressed: () {
            //               // Respond to button press
            //               context.goNamed(Routes.discover);
            //             },
            //             child: const Padding(
            //                 padding: EdgeInsets.only(
            //                     left: 12.0, right: 12.0, top: 10, bottom: 10),
            //                 child: Text("Follow",
            //                     style: TextStyle(fontSize: 13.0))),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(right: 4.0),
            //           child: RawMaterialButton(
            //             constraints: BoxConstraints.tight(const Size(38, 38)),
            //             onPressed: () {},
            //             elevation: 4.0,
            //             fillColor: NowUIColors.defaultColor,
            //             padding: const EdgeInsets.all(0.0),
            //             shape: const CircleBorder(),
            //             child: const Icon(FontAwesomeIcons.twitter,
            //                 size: 14.0, color: Colors.white),
            //           ),
            //         ),
            //         RawMaterialButton(
            //           constraints: BoxConstraints.tight(const Size(38, 38)),
            //           onPressed: () {},
            //           elevation: 4.0,
            //           fillColor: NowUIColors.defaultColor,
            //           padding: const EdgeInsets.all(0.0),
            //           shape: const CircleBorder(),
            //           child: const Icon(FontAwesomeIcons.pinterest,
            //               size: 14.0, color: Colors.white),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
