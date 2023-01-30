import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:traveltime/constants/constants.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/connectivity_status.dart';
import 'package:traveltime/utils/shared_preferences.dart';

enum DBSyncStatus {
  runing,
  pending,
  error,
}

class DBSyncState {
  final DBSyncStatus status;
  final DateTime? lastSync;
  final bool? firstRun;
  DBSyncState({required this.status, this.lastSync, this.firstRun = false});
}

class DbSync extends AsyncNotifier<DBSyncState> {
  DbSync() : super() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: true,
    ));
  }

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://79.98.28.215:1337/api',
    connectTimeout: 5000,
    receiveTimeout: 30000,
  ));

  late Isar db;

  late AppAuthorized user;

  Timer? timer;

  CancelToken? cancelToken;

  bool get firstRun {
    final prefs = ref.read(sharedPreferencesProvider);
    final String? lastSyncValue = prefs.getString(lastSyncName);
    return lastSyncValue == null;
  }

  String get lastSyncName {
    return '${db.name}:lastSync';
  }

  DateTime? get lastSync {
    final prefs = ref.read(sharedPreferencesProvider);
    final String? lastSyncValue = prefs.getString(lastSyncName);
    return lastSyncValue != null ? DateTime.parse(lastSyncValue) : null;
  }

  set lastSync(DateTime? value) {
    final prefs = ref.read(sharedPreferencesProvider);
    if (value != null) {
      prefs.setString(lastSyncName, value.toIso8601String());
    } else {
      prefs.remove(lastSyncName);
    }
  }

  @override
  Future<DBSyncState> build() async {
    db = await ref.watch(dbProvider.future);
    user = await ref.watch(appAuthProvider.future);
    _restart();
    return DBSyncState(status: DBSyncStatus.runing);
  }

  Future<void> _restart() async {
    timer?.cancel();
    cancelToken?.cancel('cancelled');
    Timer.run(() => _run());
    timer = Timer.periodic(const Duration(minutes: 10), (_) {
      _run();
    });
  }

  Future<void> _run() async {
    final connectivityStatus = ref.read(connectivityStatusProvider);
    if (connectivityStatus == ConnectivityStatus.isDisonnected) {
      state = AsyncValue.data(DBSyncState(
          status: DBSyncStatus.pending,
          lastSync: lastSync,
          firstRun: firstRun));
      return;
    }

    state = AsyncValue.data(DBSyncState(status: DBSyncStatus.runing));

    // await Future.delayed(const Duration(seconds: 3));

    state = await AsyncValue.guard(() async {
      cancelToken = CancelToken();
      final response = await dio.get('/sync',
          queryParameters: {
            'lastSync': lastSync?.toIso8601String(),
            'locale': user.locale.name,
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

      lastSync = datetime;
      return DBSyncState(status: DBSyncStatus.pending, lastSync: datetime);
    });

    // https://api.dart.dev/stable/2.19.0/dart-async/StreamController-class.html
    // https://stackoverflow.com/questions/66724183/how-can-i-queue-calls-to-an-async-function-and-execute-them-in-order
    // https://pub.dev/packages/queue
    // https://www.linkedin.com/pulse/flutter-handling-offline-scenarios-juan-manuel-del-boca/
  }
}

final dbSyncProvider = AsyncNotifierProvider<DbSync, DBSyncState>(() {
  return DbSync();
});
