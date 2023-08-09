import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_button.dart';
import 'package:traveltime/store/models/point.dart';

class OverviewOpenapp extends StatelessWidget {
  const OverviewOpenapp({super.key, required this.point});

  final Point point;

  @override
  Widget build(BuildContext context) {
    return OverviewButton(
      title: 'On Map',
      icon: Icons.share_location,
      onPressed: () {
        MapsLauncher.launchCoordinates(
          point.lat,
          point.lng,
        );
      },
    );
  }
}
