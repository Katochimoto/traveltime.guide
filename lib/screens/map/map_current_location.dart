import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:traveltime/providers/map_current_location.dart';
import 'package:traveltime/providers/map_follow_location.dart';

class MapCurrentLocation extends ConsumerWidget {
  const MapCurrentLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followOnLocationUpdate = ref.watch(mapFollowLocationProvider);
    final followCurrentLocationStream =
        ref.read(mapCurrentLocationProvider.notifier).stream;

    return CurrentLocationLayer(
      followCurrentLocationStream: followCurrentLocationStream,
      followOnLocationUpdate: followOnLocationUpdate,
    );
  }
}
