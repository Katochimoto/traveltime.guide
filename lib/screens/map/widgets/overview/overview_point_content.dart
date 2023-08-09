import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_bookmark.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_openapp.dart';
import 'package:traveltime/widgets/overview/overview_web.dart';
import 'package:traveltime/screens/map/widgets/overview/point_events.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/widgets/overview/overview_content.dart';

class OverviewPointContent extends StatelessWidget {
  const OverviewPointContent({super.key, this.sc, required this.point});

  final ScrollController? sc;
  final models.Point point;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(UIGap.g3),
            topRight: Radius.circular(UIGap.g3)),
      ),
      child: OverviewContent(
        sc: sc,
        coverImage: point.coverImg,
        title: point.title,
        subtitle: point.address,
        content: point.description,
        actions: [
          if (point.web != null) OverviewWeb(url: point.web!),
          OverviewOpenapp(point: point),
          OverviewBookmark(point: point),
        ],
        extra: [
          const SizedBox(height: UIGap.g2),
          PointEvents(
            point: point,
            padding: const EdgeInsets.symmetric(vertical: UIGap.g2),
          ),
        ],
      ),
    );
  }
}
