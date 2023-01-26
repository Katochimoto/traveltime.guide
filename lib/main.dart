import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveltime/constants/theme/dark.dart';
import 'package:traveltime/constants/theme/light.dart';
import 'package:traveltime/providers.dart';
import 'package:traveltime/routes.dart';
import 'package:traveltime/constants/constants.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final sharedPreferences = await SharedPreferences.getInstance();

  await SentryFlutter.init((options) {
    options.dsn =
        'https://e74cf6f91970450ca01f76a528c43398@o286723.ingest.sentry.io/4504571383316480';
    options.tracesSampleRate = 1.0;
  },
      appRunner: () => runApp(ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            ],
            child: const App(),
          )));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  // late DbSync? dbSync;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  void dispose() {
    // dbSync?.stop();
    // ref.read(dbSyncProvider2).stop();
    super.dispose();
  }

  void initialization() async {
    // ref.read(dbSyncProvider2).start();
    // dbSync = await ref.watch(dbSyncProvider.future);
    // dbSync?.start();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    WidgetsBinding.instance.addPostFrameCallback(((_) {
      FlutterNativeSplash.remove();
    }));

    return MaterialApp.router(
      // title: 'Now UI PRO Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: themeMode == AppTheme.light
          ? ThemeMode.light
          : (themeMode == AppTheme.light ? ThemeMode.dark : ThemeMode.system),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale.fromSubtags(languageCode: locale.name),
      routerConfig: router,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
    );
  }
}
