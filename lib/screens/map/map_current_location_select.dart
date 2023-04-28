import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_current_location.dart';
import 'package:traveltime/providers/map_follow_location.dart';

class MapCurrentLocationSelect extends ConsumerWidget {
  const MapCurrentLocationSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: 20,
      bottom: 140,
      child: FloatingActionButton(
        heroTag: 'map_current_location',
        onPressed: () {
          ref.read(mapFollowLocationProvider.notifier).always();
          ref.read(mapCurrentLocationProvider.notifier).zoom();
        },
        child: const Icon(
          Icons.my_location,
          size: 25,
        ),
      ),
    );
  }
}
