import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SYNC_API_TOKEN', obfuscate: true)
  static final String syncApiToken = _Env.syncApiToken;

  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static final String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _Env.sentryDsn;

  @EnviedField(varName: 'OPEN_WEATHER_API', obfuscate: true)
  static final String openWeatherApi = _Env.openWeatherApi;
}
