import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:traveltime/providers/current_weather.dart';
import 'package:traveltime/utils/env.dart';

final Dio weatherApi = Dio(BaseOptions(
  baseUrl: 'https://api.openweathermap.org/data/2.5',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 30),
));

final Dio geoApi = Dio(BaseOptions(
  baseUrl: 'https://api.openweathermap.org/geo/1.0',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 30),
));

class CurrentWeatherController extends Notifier<CurrentWeather?> {
  @override
  CurrentWeather? build() {
    fetch();
    return null;
  }

  Future<void> fetch() async {
    final weather = await weatherApi.get(
      '/weather',
      queryParameters: {
        'lat': '13.0508',
        'lon': '100.9367',
        'appid': Env.openWeatherApi,
        'units': 'metric',
      },
    );

    final geo = await geoApi.get(
      '/reverse',
      queryParameters: {
        'lat': '13.0508',
        'lon': '100.9367',
        'appid': Env.openWeatherApi,
        'limit': '1',
      },
    );

    state = CurrentWeather.fromJson({...weather.data, 'geo': geo.data});
  }
}

final currentWeatherProvider =
    NotifierProvider<CurrentWeatherController, CurrentWeather?>(() {
  return CurrentWeatherController();
});
