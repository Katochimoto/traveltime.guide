class CurrentWeather {
  const CurrentWeather({
    required this.dateTime,
    required this.weatherIcon,
    required this.weatherMain,
    required this.weatherDescription,
    required this.address,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.tempFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.visibility,
    required this.cloudiness,
  });

  final DateTime dateTime;
  final String weatherIcon;
  final String weatherMain;
  final String weatherDescription;
  final String address;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double tempFeelsLike;
  final double pressure; // hPa
  final double humidity; // %
  final double seaLevel;
  final double grndLevel;
  final double windSpeed;
  final double windDeg;
  final double windGust;
  final double visibility; // meters
  final double cloudiness; // %

  factory CurrentWeather.fromJson(dynamic data) {
    final weather = data['weather'][0];
    final main = data['main'];
    final wind = data['wind'];
    final clouds = data['clouds'];
    final geo = data['geo'][0];
    return CurrentWeather(
      dateTime:
          DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000, isUtc: true),
      address: geo?['name'] ?? data['name'],
      weatherIcon:
          'https://openweathermap.org/img/wn/${weather['icon']}@2x.png',
      weatherMain: weather['main'],
      weatherDescription: weather['description'],
      temp: double.parse(main['temp'].toString()),
      tempMin: double.parse(main['temp_min'].toString()),
      tempMax: double.parse(main['temp_max'].toString()),
      tempFeelsLike: double.parse(main['feels_like'].toString()),
      pressure: double.parse(main['pressure'].toString()),
      humidity: double.parse(main['humidity'].toString()),
      seaLevel: double.parse(main['sea_level'].toString()),
      grndLevel: double.parse(main['grnd_level'].toString()),
      windSpeed: double.parse(wind['speed'].toString()),
      windDeg: double.parse(wind['deg'].toString()),
      windGust: double.parse(wind['gust'].toString()),
      visibility: double.parse(data['visibility'].toString()),
      cloudiness: double.parse(clouds['all'].toString()),
    );
  }
}
