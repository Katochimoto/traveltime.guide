import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: 'https://api.openweathermap.org/data/2.5',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 30),
));

class CurrentWeather {
  const CurrentWeather({
    required this.name,
  });

  final String name;

  factory CurrentWeather.fromJson(dynamic data) {
    return CurrentWeather(
      name: data['name'],
    );
  }
}

final currentWeatherProvider = FutureProvider<CurrentWeather>((ref) async {
  // final response = await dio.get(
  //   '/weather',
  //   queryParameters: {
  //     'lat': '13.0508',
  //     'lon': '100.9367',
  //     'appid': '27b74938c3db783a84f6d0722ea2bdba',
  //     'units': 'metric',
  //   },
  // );

  // log(jsonEncode(response.data));

  final data = {
    "coord": {"lon": 100.9367, "lat": 13.0508},
    "weather": [
      {
        "id": 803,
        "main": "Clouds",
        "description": "broken clouds",
        "icon": "04n"
      }
    ],
    "base": "stations",
    "main": {
      "temp": 31.27,
      "feels_like": 38.27,
      "temp_min": 27.99,
      "temp_max": 31.27,
      "pressure": 1007,
      "humidity": 81,
      "sea_level": 1007,
      "grnd_level": 1006
    },
    "visibility": 10000,
    "wind": {"speed": 3.56, "deg": 158, "gust": 4.39},
    "clouds": {"all": 82},
    "dt": 1691759126,
    "sys": {
      "type": 2,
      "id": 2074273,
      "country": "TH",
      "sunrise": 1691708604,
      "sunset": 1691753992
    },
    "timezone": 25200,
    "id": 1619423,
    "name": "Bang Lamung",
    "cod": 200
  };

  return CurrentWeather.fromJson(data); // response.data
});
