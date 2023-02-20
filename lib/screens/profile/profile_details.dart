import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/widgets/page_layout.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 2,
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imgs/drawer_bg.jpg'),
                      fit: BoxFit.cover)),
              child: Stack(
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(color: Colors.black45)),
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: UIGap.g2, left: UIGap.g3, right: UIGap.g3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/imgs/logo.png'),
                            radius: 45,
                          ),
                          const SizedBox(height: UIGap.g1),
                          Text(
                            'Demo',
                            style: Theme.of(context)
                                .textTheme
                                .merge(Typography.whiteCupertino)
                                .headlineMedium,
                          ),
                          const SizedBox(height: UIGap.g1),
                          Text(
                            'Demo user',
                            style: Theme.of(context)
                                .textTheme
                                .merge(Typography.whiteCupertino)
                                .bodySmall,
                          ),
                          const SizedBox(height: UIGap.g2),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: UIGap.g3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "2K",
                                      style: Theme.of(context)
                                          .textTheme
                                          .merge(Typography.whiteCupertino)
                                          .bodyLarge,
                                    ),
                                    Text("Friends",
                                        style: Theme.of(context)
                                            .textTheme
                                            .merge(Typography.whiteCupertino)
                                            .bodySmall)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("26",
                                        style: Theme.of(context)
                                            .textTheme
                                            .merge(Typography.whiteCupertino)
                                            .bodyLarge),
                                    Text("Comments",
                                        style: Theme.of(context)
                                            .textTheme
                                            .merge(Typography.whiteCupertino)
                                            .bodySmall)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("48",
                                        style: Theme.of(context)
                                            .textTheme
                                            .merge(Typography.whiteCupertino)
                                            .bodyLarge),
                                    Text("Bookmarks",
                                        style: Theme.of(context)
                                            .textTheme
                                            .merge(Typography.whiteCupertino)
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
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: UIGap.g3),
                      child: MarkdownBody(data: 'test'),
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
    );
  }
}
