import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/providers/shared_preferences.dart';

const defaultTheme = ThemeMode.system;
const defaultLocale = Locale('en');

class AppAuthorized {
  const AppAuthorized({
    required this.locale,
    required this.theme,
  });

  final ThemeMode theme;
  final Locale locale;
}

class AppAuth extends AsyncNotifier<AppAuthorized> {
  late SharedPreferences _prefs;

  @override
  Future<AppAuthorized> build() async {
    _prefs = ref.watch(sharedPreferencesProvider);
    return authorizedFactory();
  }

  AppAuthorized authorizedFactory() {
    final locale =
        Locale(_prefs.getString('locale') ?? defaultLocale.languageCode);
    final theme =
        ThemeMode.values.byName(_prefs.getString('theme') ?? defaultTheme.name);
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
      await _prefs.setString('theme', data?.name ?? defaultTheme.name);
      return authorizedFactory();
    });
  }

  Future<void> updateLocale(Locale? data) async {
    state = await AsyncValue.guard(() async {
      await _prefs.setString(
          'locale', data?.languageCode ?? defaultLocale.languageCode);
      return authorizedFactory();
    });
  }
}

final appAuthProvider = AsyncNotifierProvider<AppAuth, AppAuthorized>(() {
  return AppAuth();
});
