import 'dart:developer' as developer;
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ConnectivityStatus { isConnected, isDisonnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    _init();
  }

  Future<void> _init() async {
    final connection = await _checkConnection();
    await _updateState(connection);
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connection) async {
      await _updateState(connection);
    });
  }

  Future<ConnectivityResult> _checkConnection() async {
    late ConnectivityResult connection;
    try {
      connection = await (Connectivity().checkConnectivity());
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      connection = ConnectivityResult.none;
    }
    return connection;
  }

  Future<void> _updateState(ConnectivityResult connection) async {
    late ConnectivityStatus next = ConnectivityStatus.isDisonnected;
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          next = ConnectivityStatus.isConnected;
        }
      } on SocketException catch (_) {
        // empty
      }
    }

    if (state != next) {
      state = next;
    }
  }
}

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
        (ref) {
  return ConnectivityStatusNotifier();
});
