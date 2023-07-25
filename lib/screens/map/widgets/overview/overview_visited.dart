import 'package:flutter/material.dart';
import 'package:traveltime/store/models/point.dart';

class OverviewVisited extends StatelessWidget {
  const OverviewVisited({super.key, required this.point});

  final Point point;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.playlist_add_check_circle),
          onPressed: () {},
          iconSize: 25,
          color: Colors.white,
        ),
        Text('Visited',
            style: Theme.of(context)
                .textTheme
                .merge(Typography.whiteCupertino)
                .bodySmall)
      ],
    );
  }
}
