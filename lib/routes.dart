import 'package:flutter/widgets.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/onboarding/onboarding_screen.dart';
import 'package:traveltime/screens/home/home_screen.dart';
import 'package:traveltime/screens/profile/profile_screen.dart';
import 'package:traveltime/screens/settings/settings_screen.dart';
import 'package:traveltime/screens/register/register_screen.dart';
import 'package:traveltime/screens/articles/articles_screen.dart';
import 'package:traveltime/screens/components/components_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Routes.home: (context) => const HomeScreen(),
  Routes.settings: (context) => const SettingsScreen(),
  Routes.onboarding: (context) => const OnboardingScreen(),
  Routes.profile: (context) => const ProfileScreen(),
  Routes.articles: (context) => const ArticlesScreen(),
  Routes.components: (context) => const ComponentsScreen(),
  Routes.account: (context) => const RegisterScreen(),
};
