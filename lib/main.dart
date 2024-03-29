import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relative_time/relative_time.dart';
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

  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.tracesSampleRate = 1.0;
      options.debug = false;
    },
    appRunner: () => runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const App(),
      ),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  void initState() {
    ref.read(dbSyncProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(((_) {
      FlutterNativeSplash.remove();
    }));

    final user = ref.watch(appAuthProvider).valueOrNull;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: user?.theme ?? defaultTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        RelativeTimeLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: user?.locale ?? defaultLocale,
      routerConfig: router,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
    );
  }
}
