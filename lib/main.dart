import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/constants/theme/dark.dart';
import 'package:traveltime/constants/theme/light.dart';
import 'package:traveltime/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Now UI PRO Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: darkTheme, //lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: const Locale.fromSubtags(languageCode: 'en'),
      initialRoute: Routes.onboarding,
      routes: routes,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
    );
  }
}
