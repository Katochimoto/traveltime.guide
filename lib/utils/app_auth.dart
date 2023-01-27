import 'package:flutter/material.dart';
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

class AppAuth extends ChangeNotifier {
  AppAuthorized authorized = AppAuthorizedDemo();

  Future<void> checkAuth() async {
    // authorized = AppAuthorizedDemo();
    // notifyListeners();
  }

  Future<void> signIn() async {
    // authorized = AppAuthorizedDemo();
    // notifyListeners();
  }

  Future<void> signOut() async {
    // authorized = AppAuthorizedDemo();
    // notifyListeners();
  }
}

final appAuthProvider = ChangeNotifierProvider<AppAuth>(((ref) {
  // final pref = ref.watch(sharedPreferencesProvider);
  return AppAuth();
}));
