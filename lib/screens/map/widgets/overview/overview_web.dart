import 'package:flutter/material.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_button.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/utils/url_launch.dart';

class OverviewWeb extends StatelessWidget {
  const OverviewWeb({super.key, required this.point});

  final models.Point point;

  @override
  Widget build(BuildContext context) {
    return OverviewButton(
      title: 'Web',
      icon: Icons.open_in_browser,
      onPressed: () {
        urlLaunch(point.web);
      },
    );
  }
}
