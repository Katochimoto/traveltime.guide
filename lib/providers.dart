import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AppTheme {
  system,
  light,
  dark,
}

enum AppLocale {
  en,
  th,
}

final themeModeProvider = StateProvider<AppTheme>((ref) => AppTheme.system);

final localeProvider = StateProvider<AppLocale>((ref) => AppLocale.en);
