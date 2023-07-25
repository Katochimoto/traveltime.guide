import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/providers/shared_preferences.dart';

enum AppLocale {
  en,
  th,
}

class AppAuthorized {
  ThemeMode theme;
  AppLocale locale;

  AppAuthorized({
    this.locale = AppLocale.en,
    this.theme = ThemeMode.system,
  });
}

class AppAuth extends AsyncNotifier<AppAuthorized> {
  late SharedPreferences _prefs;

  @override
  Future<AppAuthorized> build() async {
    _prefs = ref.watch(sharedPreferencesProvider);
    return authorizedFactory();
  }

  AppAuthorized authorizedFactory() {
    final locale = AppLocale.values
        .byName(_prefs.getString('locale') ?? AppLocale.en.name);
    final theme = ThemeMode.values
        .byName(_prefs.getString('theme') ?? ThemeMode.system.name);
    return AppAuthorized(locale: locale, theme: theme);
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return authorizedFactory();
    });
  }

  Future<void> updateTheme(ThemeMode? data) async {
    state = await AsyncValue.guard(() async {
      await _prefs.setString('theme', data?.name ?? ThemeMode.system.name);
      return authorizedFactory();
    });
  }

  Future<void> updateLocale(AppLocale? data) async {
    state = await AsyncValue.guard(() async {
      await _prefs.setString('locale', data?.name ?? AppLocale.en.name);
      return authorizedFactory();
    });
  }
}

final appAuthProvider = AsyncNotifierProvider<AppAuth, AppAuthorized>(() {
  return AppAuth();
});
