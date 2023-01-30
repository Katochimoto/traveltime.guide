import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  AppAuthorized(
      {required this.role,
      this.locale = AppLocale.en,
      this.theme = AppTheme.system});

  Future<void> updateTheme(AppTheme data) async {}
}

class AppAuthorizedDemo extends AppAuthorized {
  AppAuthorizedDemo({super.role = AppAuthRole.demo});
}

class AppAuthorizedUser extends AppAuthorized {
  AppAuthorizedUser({super.role = AppAuthRole.user});
}

class AppAuthorizedAdmin extends AppAuthorized {
  AppAuthorizedAdmin({super.role = AppAuthRole.admin});
}

class AppAuth extends AsyncNotifier<AppAuthorized> {
  @override
  Future<AppAuthorized> build() async {
    return AppAuthorizedDemo();
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // final response = await dio.get('...');
      // return Data.fromJson(response);
      return AppAuthorizedDemo();
    });
  }
}

final appAuthProvider = AsyncNotifierProvider<AppAuth, AppAuthorized>(() {
  return AppAuth();
});
