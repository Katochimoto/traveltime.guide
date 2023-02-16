import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/screens/map/overview_provider.dart';
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
                ref.read(overviewProvider.notifier).hide();
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
          flex: point.coverImg == null ? 1 : 2,
          child: Stack(
            children: <Widget>[
              if (point.coverImg != null) ...[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(UIGap.g3),
                          topRight: Radius.circular(UIGap.g3)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(point.coverImg!),
                          fit: BoxFit.cover)),
                  child: Container(),
                ),
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UIGap.g3),
                            topRight: Radius.circular(UIGap.g3)),
                        color: Colors.black45)),
              ],
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
                    if (point.address != null) ...[
                      const SizedBox(height: UIGap.g1),
                      Text(point.address!,
                          style: Theme.of(context)
                              .textTheme
                              .merge(Typography.whiteCupertino)
                              .bodySmall),
                    ],
                    const SizedBox(height: UIGap.g2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: UIGap.g3),
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
