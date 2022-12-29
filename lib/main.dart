import 'package:flutter/material.dart';
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
        title: 'Now UI PRO Flutter',
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme, //lightTheme,
        // ThemeData(
        //   // splashColor: Colors.red,
        //   // highlightColor: Colors.black.withOpacity(.5),
        // ),
        initialRoute: Routes.onboarding,
        routes: routes);
  }
}
