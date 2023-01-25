import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:traveltime/providers.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/constants/constants.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/connectivity_status.dart';

// dbSyncProgress
// dbSyncFirstRun

final dbSyncProvider = FutureProvider((ref) async {
  final locale = ref.watch(localeProvider);
  final db = await ref.watch(dbProvider.future);
  final connectivityStatus = ref.watch(connectivityStatusProvider);
  return DbSync(db, locale, connectivityStatus);
});

class DbSync {
  static final DbSync _instance = DbSync._internal();

  factory DbSync(
      Isar db, AppLocale locale, ConnectivityStatus connectivityStatus) {
    _instance.db = db;
    _instance.locale = locale;
    _instance.connectivityStatus = connectivityStatus;
    return _instance;
  }

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://79.98.28.215:1337/api',
    connectTimeout: 5000,
    receiveTimeout: 30000,
  ));

  late Isar db;

  late AppLocale locale;

  late ConnectivityStatus connectivityStatus;

  late CancelToken? cancelToken;

  late Timer? timer;

  DbSync._internal() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: true,
    ));
  }

  // retry on error
  // offline pause
  Future<void> start() async {
    // stop();
    await run();
    timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
      await run();
    });
  }

  void stop() {
    timer?.cancel();
    cancelToken?.cancel('cancelled');
  }

  Future<void> run() async {
    if (connectivityStatus == ConnectivityStatus.isDisonnected) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final String lastSyncName = '${db.name}:lastSync';
    final String? lastSync = prefs.getString(lastSyncName);

    // https://api.dart.dev/stable/2.19.0/dart-async/StreamController-class.html
    // https://stackoverflow.com/questions/66724183/how-can-i-queue-calls-to-an-async-function-and-execute-them-in-order
    // https://pub.dev/packages/queue
    // https://www.linkedin.com/pulse/flutter-handling-offline-scenarios-juan-manuel-del-boca/

    try {
      cancelToken = CancelToken();
      final response = await dio.get('/sync',
          queryParameters: {
            'lastSync': lastSync,
            'locale': locale.name,
          },
          options: Options(headers: {
            'Authorization':
                'Bearer eec9ab5c756e5affb6821b7d186631f61d53c68de0b276d5bca8c09b374b2abb57edbdb73f07e0d83c5d5c81c6d30ec91d6581365316e9bd49424ef1c37b90632006bca575902cb745af2cb47ad47d73946fc7d36cd7c4fd034c9936e594366749a39350dfcc12a992447e291942cffde1c9c435683fe664cc22aee856dc0636'
          }),
          cancelToken: cancelToken);

      final DateTime datetime = DateTime.parse(response.data['datetime']);

      await db.writeTxn(() async {
        // *** articles ****
        final changes = response.data?['changes']?['articles'];
        if (changes?['deleted']?.isNotEmpty) {
          await db.articles.deleteAll(changes['deleted']);
        }
        if (changes?['replaced']?.isNotEmpty) {
          final List<Article> items = [];
          for (var item in changes['replaced']) {
            items.add(Article.fromJson(item));
          }

          await db.articles.putAll(items);
        }
        // *** /articles ****
      });

      await prefs.setString(lastSyncName, datetime.toIso8601String());

      print(response.data['changes']);
    } catch (e) {
      print(e);
    } finally {
      cancelToken = null;
    }
  }
}
