import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_bookmark.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_openapp.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_web.dart';
import 'package:traveltime/screens/map/widgets/overview/point_events.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/utils/url_launch.dart';

class OverviewPointContent extends StatelessWidget {
  const OverviewPointContent({super.key, this.sc, required this.point});

  final ScrollController? sc;
  final models.Point point;

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
                          image: NetworkImage(point.coverImg!),
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
                          .headlineSmall,
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
                          if (point.web != null) OverviewWeb(point: point),
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
          child: ListView(
            controller: sc,
            padding: const EdgeInsets.all(UIGap.g3),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              MarkdownBody(
                data: point.description,
                onTapLink: (text, href, title) => urlLaunch(href),
              ),
              PointEvents(
                point: point,
                padding: const EdgeInsets.symmetric(vertical: UIGap.g2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
