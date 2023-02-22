import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:traveltime/store/models/point.dart';

class OverviewOpenapp extends StatelessWidget {
  const OverviewOpenapp({super.key, required this.point});

  final Point point;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.share_location),
          onPressed: () {
            MapsLauncher.launchCoordinates(
              point.lat,
              point.lng,
            );
          },
          iconSize: 25,
          color: Colors.white70,
        ),
        Text('Map App',
            style: Theme.of(context)
                .textTheme
                .merge(Typography.whiteCupertino)
                .bodySmall)
      ],
    );
  }
}
