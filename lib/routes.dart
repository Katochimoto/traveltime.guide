import 'package:flutter/widgets.dart';
import 'package:teamtravel/screens/onboarding/onboarding_screen.dart';
import 'package:teamtravel/screens/pro/pro_screen.dart';
import 'package:teamtravel/screens/home/home_screen.dart';
import 'package:teamtravel/screens/profile/profile_screen.dart';
import 'package:teamtravel/screens/settings/settings_screen.dart';
import 'package:teamtravel/screens/register/register_screen.dart';
import 'package:teamtravel/screens/articles/articles_screen.dart';
import 'package:teamtravel/screens/components/components_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  ProScreen.routeName: (context) => ProScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ArticlesScreen.routeName: (context) => ArticlesScreen(),
  ComponentsScreen.routeName: (context) => ComponentsScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
};
