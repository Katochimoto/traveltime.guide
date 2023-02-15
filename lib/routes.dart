import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/map/map_screen.dart';
import 'package:traveltime/screens/onboarding/onboarding_screen.dart';
import 'package:traveltime/screens/home/home_screen.dart';
import 'package:traveltime/screens/profile/profile_screen.dart';
import 'package:traveltime/screens/settings/settings_screen.dart';
import 'package:traveltime/screens/register/register_screen.dart';
import 'package:traveltime/screens/articles/articles_screen.dart';
import 'package:traveltime/screens/article/article_screen.dart';
import 'package:traveltime/screens/components/components_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  // errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: <RouteBase>[
    GoRoute(
      name: Routes.home,
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: Routes.discover,
      path: '/discover',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: Routes.settings,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: Routes.profile,
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      name: Routes.articles,
      path: '/articles',
      builder: (context, state) => const ArticlesScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: Routes.article,
          path: ':id',
          builder: (context, state) => ArticleScreen(
            id: int.parse(state.params['id']!),
          ),
        ),
      ],
    ),
    GoRoute(
      name: Routes.components,
      path: '/components',
      builder: (context, state) => const ComponentsScreen(),
    ),
    GoRoute(
      name: Routes.account,
      path: '/account',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: Routes.map,
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
  ],
);
