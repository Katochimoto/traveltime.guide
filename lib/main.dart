import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/constants/theme/dark.dart';
import 'package:traveltime/constants/theme/light.dart';
import 'package:traveltime/routes.dart';
import 'package:traveltime/store/db_sync.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/providers/shared_preferences.dart';
import 'package:traveltime/utils/env.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final sharedPreferences = await SharedPreferences.getInstance();

  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDsn;
    options.tracesSampleRate = 1.0;
  },
      appRunner: () => runApp(ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(sharedPreferences),
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

    ref.watch(dbSyncProvider);

    final user = ref.watch(appAuthProvider).value;

    return MaterialApp.router(
      // title: 'Now UI PRO Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: user?.theme == AppTheme.light
          ? ThemeMode.light
          : (user?.theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.system),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale.fromSubtags(languageCode: user?.locale.name ?? 'en'),
      routerConfig: router,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
    );
  }
}
