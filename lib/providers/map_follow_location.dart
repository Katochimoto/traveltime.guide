import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapFollowLocation extends Notifier<FollowOnLocationUpdate> {
  @override
  FollowOnLocationUpdate build() {
    return FollowOnLocationUpdate.never;
  }

  void never() {
    if (state != FollowOnLocationUpdate.never) {
      state = FollowOnLocationUpdate.never;
    }
  }

  void always() {
    if (state != FollowOnLocationUpdate.always) {
      state = FollowOnLocationUpdate.always;
    }
  }
}

final mapFollowLocationProvider =
    NotifierProvider<MapFollowLocation, FollowOnLocationUpdate>(() {
  return MapFollowLocation();
});
