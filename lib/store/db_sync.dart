import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/providers.dart';
import 'package:traveltime/store/db.dart';

// dbSyncProgress
// dbSyncFirstRun

final dbSyncProvider = FutureProvider((ref) async {
  final locale = ref.watch(localeProvider);
  final db = await ref.watch(dbProvider.future);
  return DbSync(db, locale);
});

class DbSync {
  DbSync(this.db, this.locale);

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://79.98.28.215:1337/api',
    connectTimeout: 5000,
    receiveTimeout: 30000,
  ));

  final Isar db;

  final AppLocale locale;

  late CancelToken? cancelToken;

  void start() async {
    final prefs = await SharedPreferences.getInstance();
    final String lastSyncName = '${db.name}:lastSync';
    final String? lastSync = prefs.getString(lastSyncName);

    try {
      cancelToken = CancelToken();
      final response = await dio.get('/sync',
          queryParameters: {'lastSync': lastSync, 'locale': locale},
          options: Options(headers: {
            'Authorization':
                'Bearer eec9ab5c756e5affb6821b7d186631f61d53c68de0b276d5bca8c09b374b2abb57edbdb73f07e0d83c5d5c81c6d30ec91d6581365316e9bd49424ef1c37b90632006bca575902cb745af2cb47ad47d73946fc7d36cd7c4fd034c9936e594366749a39350dfcc12a992447e291942cffde1c9c435683fe664cc22aee856dc0636'
          }),
          cancelToken: cancelToken);

      final DateTime datetime = DateTime.parse(response.data['datetime']);

      // await prefs.setString(lastSyncName, datetime.toIso8601String());

      print(lastSync);
      print(response.data['changes']);
    } catch (e) {
      print(e);
    } finally {
      cancelToken = null;
    }
  }

  void stop() {
    cancelToken?.cancel('cancelled');
  }
}
