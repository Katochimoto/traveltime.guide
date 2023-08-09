import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/event/event_points.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/widgets/overview/overview_content.dart';
import 'package:traveltime/widgets/overview/overview_web.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.event, this.date});

  final models.Event event;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final instance = event.instanceOnDay(date ?? DateTime.now());
    final upcomingInstance = event.upcomingInstanceFrom(date ?? DateTime.now());

    return OverviewContent(
      coverImage: event.coverImg,
      title: event.title,
      subtitle:
          '$instance${upcomingInstance != null ? '\nUpcoming: $upcomingInstance' : ''}',
      content: event.description,
      actions: [
        if (event.web != null) OverviewWeb(url: event.web!),
      ],
      extra: [
        const SizedBox(height: UIGap.g2),
        EventPoints(event: event, date: date),
        // const PhotoAlbum(imgArray: [
        //   "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80",
        //   "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80",
        // ])
      ],
    );
  }
}
