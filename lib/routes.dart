import 'package:flutter/widgets.dart';
import 'package:teamtravel/constants/routes.dart';
import 'package:teamtravel/screens/onboarding/onboarding_screen.dart';
import 'package:teamtravel/screens/home/home_screen.dart';
import 'package:teamtravel/screens/profile/profile_screen.dart';
import 'package:teamtravel/screens/settings/settings_screen.dart';
import 'package:teamtravel/screens/register/register_screen.dart';
import 'package:teamtravel/screens/articles/articles_screen.dart';
import 'package:teamtravel/screens/components/components_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Routes.home: (context) => const HomeScreen(),
  Routes.settings: (context) => const SettingsScreen(),
  Routes.onboarding: (context) => const OnboardingScreen(),
  Routes.profile: (context) => const ProfileScreen(),
  Routes.articles: (context) => const ArticlesScreen(),
  Routes.components: (context) => const ComponentsScreen(),
  Routes.account: (context) => const RegisterScreen(),
};
