import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SYNC_API_TOKEN')
  static const String syncApiToken = _Env.syncApiToken;

  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'SENTRY_DSN')
  static const String sentryDsn = _Env.sentryDsn;

  @EnviedField(varName: 'OPEN_WEATHER_API')
  static const String openWeatherApi = _Env.openWeatherApi;
}
