import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/constants/constants.dart';

final themeModeProvider = StateProvider<AppTheme>((ref) => AppTheme.system);

final localeProvider = StateProvider<AppLocale>((ref) => AppLocale.en);

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
