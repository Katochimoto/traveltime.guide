import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/constants/constants.dart';
import 'package:traveltime/constants/theme/dark.dart';
import 'package:traveltime/constants/theme/light.dart';
import 'package:traveltime/routes.dart';
import 'package:traveltime/store/db_sync.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/app_support_directory.dart';
import 'package:traveltime/utils/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final sharedPreferences = await SharedPreferences.getInstance();
  final dir = await getApplicationSupportDirectory();

  await SentryFlutter.init((options) {
    options.dsn = sentryDSN;
    options.tracesSampleRate = 1.0;
  },
      appRunner: () => runApp(ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(sharedPreferences),
              appSupportDirectoryProvider.overrideWithValue(dir),
            ],
            child: const App(),
          )));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(((_) {
      FlutterNativeSplash.remove();
    }));

    ref.read(dbSyncProvider).start();

    final theme =
        ref.watch(appAuthProvider.select((auth) => auth.authorized.theme));
    final locale =
        ref.watch(appAuthProvider.select((auth) => auth.authorized.locale));

    return MaterialApp.router(
      // title: 'Now UI PRO Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: theme == AppTheme.light
          ? ThemeMode.light
          : (theme == AppTheme.light ? ThemeMode.dark : ThemeMode.system),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale.fromSubtags(languageCode: locale.name),
      routerConfig: router,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
    );
  }
}
