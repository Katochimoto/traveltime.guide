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
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: true,
    ));
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://79.98.28.215:1337/api',
    connectTimeout: 5000,
    receiveTimeout: 30000,
  ));

  late Isar _db;

  late AppLocale _locale;

  Timer? _timer;

  CancelToken? _cancelToken;

  bool get _firstRun {
    final prefs = ref.read(sharedPreferencesProvider);
    final String? lastSyncValue = prefs.getString(_lastSyncName);
    return lastSyncValue == null;
  }

  String get _lastSyncName {
    return '${_db.name}:lastSync';
  }

  DateTime? get _lastSync {
    final prefs = ref.read(sharedPreferencesProvider);
    final String? lastSyncValue = prefs.getString(_lastSyncName);
    return lastSyncValue != null ? DateTime.parse(lastSyncValue) : null;
  }

  Future<void> _updateLastSync(DateTime? value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (value != null) {
      await prefs.setString(_lastSyncName, value.toIso8601String());
    } else {
      await prefs.remove(_lastSyncName);
    }
  }

  @override
  Future<DBSyncState> build() async {
    _db = await ref.watch(dbProvider.future);
    _locale =
        await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
    _restart();
    return DBSyncState(status: DBSyncStatus.runing);
  }

  Future<void> reset() async {
    await _db.writeTxn(() async {
      await _db.clear();
    });
    await _updateLastSync(null);
    await _restart();
  }

  Future<void> _restart() async {
    _timer?.cancel();
    _cancelToken?.cancel('cancelled');
    Timer.run(() => _run());
    _timer = Timer.periodic(const Duration(minutes: 10), (_) {
      _run();
    });
  }

  Future<void> _run() async {
    final connectivityStatus = ref.read(connectivityStatusProvider);
    if (connectivityStatus == ConnectivityStatus.isDisonnected) {
      state = AsyncValue.data(DBSyncState(
          status: DBSyncStatus.pending,
          lastSync: _lastSync,
          firstRun: _firstRun));
      return;
    }

    state = AsyncValue.data(DBSyncState(status: DBSyncStatus.runing));

    // await Future.delayed(const Duration(seconds: 3));

    state = await AsyncValue.guard(() async {
      _cancelToken = CancelToken();
      final response = await _dio.get('/sync',
          queryParameters: {
            'lastSync': _lastSync?.toIso8601String(),
            'locale': _locale.name,
          },
          options: Options(headers: {'Authorization': 'Bearer $syncApiToken'}),
          cancelToken: _cancelToken);

      final DateTime datetime = DateTime.parse(response.data['datetime']);

      await _db.writeTxn(() async {
        // *** articles ****
        final articles = _db.collection<Article>();
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

      await _updateLastSync(datetime);
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
