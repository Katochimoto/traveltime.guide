import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/providers/connectivity_status.dart';
import 'package:traveltime/providers/shared_preferences.dart';
import 'package:traveltime/utils/env.dart';
import 'models.dart' as models;

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
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 30),
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
    return 'lastSync:${_db.name}:${_locale.name}';
  }

  DateTime? get _lastSync {
    final prefs = ref.read(sharedPreferencesProvider);
    final String? lastSyncValue = prefs.getString(_lastSyncName);
    return lastSyncValue != null ? DateTime.parse(lastSyncValue) : null;
  }

  Future<void> _updateLastSync(DateTime value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_lastSyncName, value.toIso8601String());
  }

  Future<void> _removeLastSync() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove('lastSync:${_db.name}:${AppLocale.en.name}');
    await prefs.remove('lastSync:${_db.name}:${AppLocale.th.name}');
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
    await _removeLastSync();
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

    log('Sync status: ${state.value?.status}');

    state = await AsyncValue.guard(() async {
      _cancelToken = CancelToken();
      final response = await _dio.get('/sync',
          queryParameters: {
            'lastSync': _lastSync?.toIso8601String(),
            'locale': _locale.name,
          },
          options:
              Options(headers: {'Authorization': 'Bearer ${Env.syncApiToken}'}),
          cancelToken: _cancelToken);

      final DateTime datetime = DateTime.parse(response.data['datetime']);

      await _db.writeTxn(() async {
        final List<dynamic> syncList = [
          [
            _db.collection<models.Article>(),
            models.Article.fromJsonList,
            'articles'
          ],
          [_db.collection<models.Point>(), models.Point.fromJsonList, 'points'],
          [_db.collection<models.Event>(), models.Event.fromJsonList, 'events'],
          [_db.collection<models.Route>(), models.Route.fromJsonList, 'routes'],
          [
            _db.collection<models.RouteWaypoint>(),
            models.RouteWaypoint.fromJsonList,
            'routeWaypoints'
          ],
          [
            _db.collection<models.RouteLeg>(),
            models.RouteLeg.fromJsonList,
            'routeLegs'
          ],
        ];

        for (final syncItem in syncList) {
          final collection = syncItem[0];
          final changesFromJson = syncItem[1];
          final collectionName = syncItem[2];
          log('Sync start: $collectionName');
          final changes = response.data?['changes']?[collectionName];
          if (changes?['deleted']?.isNotEmpty) {
            await collection.deleteAll(changes['deleted']);
          }
          if (changes?['replaced']?.isNotEmpty) {
            final items = changesFromJson(changes['replaced']);
            await collection.putAll(items);
          }
          log('Sync finish: $collectionName');
        }
      });

      await _updateLastSync(datetime);
      return DBSyncState(status: DBSyncStatus.pending, lastSync: datetime);
    });

    log('Sync status: ${state.value?.status}');

    // https://api.dart.dev/stable/2.19.0/dart-async/StreamController-class.html
    // https://stackoverflow.com/questions/66724183/how-can-i-queue-calls-to-an-async-function-and-execute-them-in-order
    // https://pub.dev/packages/queue
    // https://www.linkedin.com/pulse/flutter-handling-offline-scenarios-juan-manuel-del-boca/
  }
}

final dbSyncProvider = AsyncNotifierProvider<DbSync, DBSyncState>(() {
  return DbSync();
});
