import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:traveltime/constants/constants.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/connectivity_status.dart';
import 'package:traveltime/utils/shared_preferences.dart';

enum DBSyncStatus {
  runing,
  pending,
}

final dbSyncProvider = ChangeNotifierProvider<DbSync>((ref) {
  return DbSync(ref);
});

class DbSync extends ChangeNotifier {
  final Ref ref;

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://79.98.28.215:1337/api',
    connectTimeout: 5000,
    receiveTimeout: 30000,
  ));

  late CancelToken? cancelToken;

  late Timer? timer;

  late DateTime? lastSync;

  late bool firstRun = false;

  DBSyncStatus status = DBSyncStatus.pending;

  DbSync(this.ref) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: true,
    ));
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  void start() {
    Timer.run(() {
      run();
    });
    timer = Timer.periodic(const Duration(minutes: 10), (_) {
      run();
    });
  }

  void stop() {
    timer?.cancel();
    cancelToken?.cancel('cancelled');
    status = DBSyncStatus.pending;
    notifyListeners();
  }

  Future<void> run() async {
    final connectivityStatus = ref.read(connectivityStatusProvider);
    if (connectivityStatus == ConnectivityStatus.isDisonnected) {
      return;
    }

    final prefs = ref.read(sharedPreferencesProvider);
    final db = ref.read(dbProvider);
    final locale =
        ref.watch(appAuthProvider.select((auth) => auth.authorized.locale));

    final String lastSyncName = '${db.name}:lastSync';
    final String? lastSyncValue = prefs.getString(lastSyncName);

    lastSync = lastSyncValue != null ? DateTime.parse(lastSyncValue) : null;
    firstRun = lastSyncValue == null;
    status = DBSyncStatus.runing;
    notifyListeners();

    // https://api.dart.dev/stable/2.19.0/dart-async/StreamController-class.html
    // https://stackoverflow.com/questions/66724183/how-can-i-queue-calls-to-an-async-function-and-execute-them-in-order
    // https://pub.dev/packages/queue
    // https://www.linkedin.com/pulse/flutter-handling-offline-scenarios-juan-manuel-del-boca/

    try {
      cancelToken = CancelToken();
      final response = await dio.get('/sync',
          queryParameters: {
            'lastSync': lastSync?.toIso8601String(),
            'locale': locale.name,
          },
          options: Options(headers: {'Authorization': 'Bearer $syncApiToken'}),
          cancelToken: cancelToken);

      final DateTime datetime = DateTime.parse(response.data['datetime']);

      await db.writeTxn(() async {
        // *** articles ****
        final articles = db.collection<Article>();
        final changes = response.data?['changes']?['articles'];
        if (changes?['deleted']?.isNotEmpty) {
          await articles.deleteAll(changes['deleted']);
        }
        if (changes?['replaced']?.isNotEmpty) {
          final List<Article> items = [];
          for (var item in changes['replaced']) {
            items.add(Article.fromJson(item));
          }

          await articles.putAll(items);
        }
        // *** /articles ****
      });

      await prefs.setString(lastSyncName, datetime.toIso8601String());
    } catch (error) {
      Sentry.captureException(error);
    } finally {
      cancelToken = null;
    }
  }
}
