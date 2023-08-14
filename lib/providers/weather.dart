import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:traveltime/providers/current_weather.dart';
import 'package:traveltime/providers/location.dart';
import 'package:traveltime/utils/env.dart';

final Dio _weatherApi = Dio(BaseOptions(
  baseUrl: 'https://api.openweathermap.org/data/2.5',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 30),
));

final Dio _geoApi = Dio(BaseOptions(
  baseUrl: 'https://api.openweathermap.org/geo/1.0',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 30),
));

CancelToken? _cancelToken;
Timer? _timer;

class CurrentWeatherController extends StateNotifier<CurrentWeather?> {
  CurrentWeatherController({this.location}) : super(null) {
    fetch();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) => fetch());
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    _cancelToken = null;
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  final CurrentLocationState? location;

  Future<void> fetch() async {
    final lat = location?.position?.latitude.toString() ?? '13.7525';
    final lon = location?.position?.longitude.toString() ?? '100.494167';

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final weather = await _weatherApi.get(
      '/weather',
      cancelToken: _cancelToken,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': Env.openWeatherApi,
        'units': 'metric',
      },
    );

    if (_cancelToken?.isCancelled == true) {
      return;
    }

    _cancelToken = CancelToken();
    final geo = await _geoApi.get(
      '/reverse',
      cancelToken: _cancelToken,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': Env.openWeatherApi,
        'limit': '1',
      },
    );

    state = CurrentWeather.fromJson({...weather.data, 'geo': geo.data});
  }
}

final currentWeatherProvider =
    StateNotifierProvider<CurrentWeatherController, CurrentWeather?>((ref) {
  final location = ref.watch(currentLocationProvider);
  return CurrentWeatherController(location: location);
});
