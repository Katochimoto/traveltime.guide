import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapFollowLocation extends Notifier<FollowOnLocationUpdate> {
  @override
  FollowOnLocationUpdate build() {
    return FollowOnLocationUpdate.never;
  }

  void update(FollowOnLocationUpdate data) {
    if (state != data) {
      state = data;
    }
  }
}

final mapFollowLocationProvider =
    NotifierProvider<MapFollowLocation, FollowOnLocationUpdate>(() {
  return MapFollowLocation();
});
