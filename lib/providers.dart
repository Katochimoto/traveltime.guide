import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltime/constants/constants.dart';

final themeModeProvider = StateProvider<AppTheme>((ref) => AppTheme.system);

final localeProvider = StateProvider<AppLocale>((ref) => AppLocale.en);
