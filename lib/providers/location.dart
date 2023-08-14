// import 'dart:async';
// import 'dart:io';
// import 'package:here_sdk/core.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:ontrack/utils/location/location.dart';

import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart' as g;
import 'package:geolocator_apple/geolocator_apple.dart' as gapp;
import 'package:geolocator_android/geolocator_android.dart' as gand;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traveltime/utils/logger.dart';

class CurrentLocationState {
  const CurrentLocationState({
    this.position,
    this.status = g.ServiceStatus.disabled,
  });

  final g.Position? position;
  final g.ServiceStatus? status;
}

class CurrentLocationController extends StateNotifier<CurrentLocationState> {
  CurrentLocationController() : super(const CurrentLocationState()) {
    _requestPermissions().then((_) => start(), onError: (error, stackTrace) {
      logger.e(error, stackTrace: stackTrace);
    });
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  bool _started = false;
  StreamSubscription<g.Position>? _positionStream;
  StreamSubscription<g.ServiceStatus>? _serviceStatusStream;

  g.LocationSettings get _locationSettings {
    if (Platform.isAndroid) {
      return gand.AndroidSettings(
        accuracy: g.LocationAccuracy.best,
        distanceFilter: 5,
        intervalDuration: const Duration(milliseconds: 3000),
      );
    } else if (Platform.isIOS) {
      return gapp.AppleSettings(
        accuracy: g.LocationAccuracy.best,
        activityType: gapp.ActivityType.automotiveNavigation,
        distanceFilter: 5,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    }

    return const g.LocationSettings(
      accuracy: g.LocationAccuracy.best,
      distanceFilter: 5,
    );
  }

  Future<g.Position?> get lastKnownPosition async {
    return g.Geolocator.getLastKnownPosition();
  }

  Future<void> start() async {
    if (_started) {
      return;
    }

    _started = true;

    _positionStream = g.Geolocator.getPositionStream(
      locationSettings: _locationSettings,
    ).listen((g.Position? position) {
      if (position != null) {
        state = CurrentLocationState(
          position: position,
          status: g.ServiceStatus.enabled,
        );
      }
    });

    _serviceStatusStream = g.Geolocator.getServiceStatusStream()
        .listen((g.ServiceStatus status) async {
      if (status == g.ServiceStatus.enabled) {
        final position = await lastKnownPosition;
        if (position != null) {
          state = CurrentLocationState(
            position: position,
            status: g.ServiceStatus.enabled,
          );
        }
      } else {
        state = const CurrentLocationState();
      }
    });

    bool isEnabled = await g.Geolocator.isLocationServiceEnabled();
    if (isEnabled) {
      final position = await lastKnownPosition;
      if (position != null) {
        state = CurrentLocationState(
          position: position,
          status: g.ServiceStatus.enabled,
        );
      }
    }
  }

  Future<void> stop() async {
    if (!_started) {
      return;
    }

    _started = false;
    _positionStream?.cancel();
    _positionStream = null;
    _serviceStatusStream?.cancel();
    _serviceStatusStream = null;
  }

  Future<void> _requestPermissions() async {
    final isEnabled = await g.Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw 'Location services are disabled';
    }

    var permission = await g.Geolocator.checkPermission();
    if (permission == g.LocationPermission.denied) {
      permission = await g.Geolocator.requestPermission();
      if (permission == g.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw 'Location permissions are denied';
      }
    }

    if (permission == g.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw 'Location permissions are permanently denied, we cannot request permissions';
    }

    if (Platform.isAndroid) {
      // This permission is optionally needed on Android devices >= Q to improve the positioning signal.
      await Permission.activityRecognition.request();
    }
  }
}

final currentLocationProvider =
    StateNotifierProvider<CurrentLocationController, CurrentLocationState>(
        (ref) {
  return CurrentLocationController();
});
