import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/providers/shared_preferences.dart';

enum AppLocale {
  en,
  th,
}

enum AppTheme {
  system,
  light,
  dark,
}

enum AppAuthRole {
  user,
  admin,
  demo,
}

class AppAuthorized {
  AppAuthRole role;
  AppTheme theme;
  AppLocale locale;

  AppAuthorized({
    required this.role,
    this.locale = AppLocale.en,
    this.theme = AppTheme.system,
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
    final theme = AppTheme.values
        .byName(_prefs.getString('theme') ?? AppTheme.system.name);
    return AppAuthorized(role: AppAuthRole.demo, locale: locale, theme: theme);
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return authorizedFactory();
    });
  }

  Future<void> updateTheme(AppTheme? data) async {
    state = await AsyncValue.guard(() async {
      await _prefs.setString('theme', data?.name ?? AppTheme.system.name);
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
