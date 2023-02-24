import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:traveltime/providers/map_follow_location.dart';

class MapCurrentLocation extends ConsumerStatefulWidget {
  const MapCurrentLocation({super.key});

  @override
  ConsumerState<MapCurrentLocation> createState() => MapCurrentLocationState();
}

class MapCurrentLocationState extends ConsumerState<MapCurrentLocation> {
  late StreamController<double?> _followCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();

    _followCurrentLocationStreamController = StreamController<double?>();

    // ref.listen(mapTapPositionProvider, (previous, next) {
    //   painter.onTap(next.offset);
    // });
  }

  @override
  void didUpdateWidget(covariant MapCurrentLocation oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final followOnLocationUpdate = ref.watch(mapFollowLocationProvider);
    return Stack(
      children: [
        CurrentLocationLayer(
          followCurrentLocationStream:
              _followCurrentLocationStreamController.stream,
          followOnLocationUpdate: followOnLocationUpdate,
        ),
        Positioned(
          right: 20,
          bottom: 140,
          child: FloatingActionButton(
            onPressed: () {
              ref
                  .read(mapFollowLocationProvider.notifier)
                  .update(FollowOnLocationUpdate.always);
              // Follow the location marker on the map and zoom the map to level 18.
              _followCurrentLocationStreamController.add(16);
            },
            child: const Icon(
              Icons.my_location,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }
}
