import 'package:flutter/material.dart';
import 'package:teamtravel/constants/routes.dart';

import 'package:teamtravel/routes.dart';
import 'package:teamtravel/screens/onboarding/onboarding_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Now UI PRO Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        initialRoute: Routes.onboarding,
        routes: routes);
  }
}
