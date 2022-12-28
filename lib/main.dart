import 'package:flutter/material.dart';
import 'package:teamtravel/constants/routes.dart';
import 'package:teamtravel/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Now UI PRO Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          useMaterial3: true,
          // splashColor: Colors.red,
          // highlightColor: Colors.black.withOpacity(.5),
        ),
        initialRoute: Routes.onboarding,
        routes: routes);
  }
}
