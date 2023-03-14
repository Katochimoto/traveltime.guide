import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/providers/point_overview.dart';
import 'package:traveltime/screens/map/overview_bookmark.dart';
import 'package:traveltime/screens/map/overview_openapp.dart';
// import 'package:traveltime/screens/map/overview_visited.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/not_found.dart';

class OverviewNavbar extends ConsumerWidget {
  const OverviewNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: UIGap.g2, horizontal: UIGap.g2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).canvasColor,
              ),
              iconSize: 24,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.invalidate(pointOverviewProvider);
              },
            )
          ],
        ));
  }
}

class OverviewContent extends StatelessWidget {
  const OverviewContent({super.key, this.sc, required this.point});

  final ScrollController? sc;
  final Point point;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(UIGap.g3),
                      topRight: Radius.circular(UIGap.g3)),
                  image: point.coverImg != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(point.coverImg!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/imgs/drawer_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(UIGap.g3),
                          topRight: Radius.circular(UIGap.g3)),
                      color: Colors.black45)),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: UIGap.g2, left: UIGap.g3, right: UIGap.g3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      point.title,
                      style: Theme.of(context)
                          .textTheme
                          .merge(Typography.whiteCupertino)
                          .headlineMedium,
                    ),
                    if (point.address != null)
                      Text(point.address!,
                          style: Theme.of(context)
                              .textTheme
                              .merge(Typography.whiteCupertino)
                              .bodySmall),
                    const SizedBox(height: UIGap.g2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: UIGap.g3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          OverviewOpenapp(point: point),
                          OverviewBookmark(point: point),
                          // OverviewVisited(point: point),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(UIGap.g3),
            child: ListView(
              controller: sc,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                MarkdownBody(data: point.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Overview extends ConsumerWidget {
  const Overview({super.key, this.sc, required this.id});

  final int id;
  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(pointProvider(id));
    return point.when(
      data: (data) {
        return data == null
            ? Stack(children: const [NotFound(), OverviewNavbar()])
            : Stack(
                children: [
                  OverviewContent(point: data, sc: sc),
                  const OverviewNavbar(),
                ],
              );
      },
      error: (error, stackTrace) {
        return Stack(children: const [NotFound(), OverviewNavbar()]);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
