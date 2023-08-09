import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/event/event_screen.dart';
import 'package:traveltime/screens/events/events_screen.dart';
import 'package:traveltime/screens/map/map_screen.dart';
import 'package:traveltime/screens/onboarding/onboarding_screen.dart';
import 'package:traveltime/screens/home/home_screen.dart';
import 'package:traveltime/screens/profile/profile_screen.dart';
import 'package:traveltime/screens/settings/settings_screen.dart';
import 'package:traveltime/screens/articles/articles_screen.dart';
import 'package:traveltime/screens/article/article_screen.dart';
import 'package:traveltime/screens/static/static_screen.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/utils/extra_nav_params.dart';

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
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
      ],
    ),
    GoRoute(
      name: Routes.map,
      path: '/map',
      builder: (context, state) => MapScreen(
        onBack: (state.extra as ExtraNavParams?)?.onBack,
      ),
    ),
    GoRoute(
      name: Routes.events,
      path: '/events',
      builder: (context, state) => const EventsScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: Routes.event,
          path: ':id',
          builder: (context, state) => EventScreen(
            id: int.parse(state.pathParameters['id']!),
            date:
                DateTime.tryParse(state.uri.queryParameters['date'].toString()),
            onBack: (state.extra as ExtraNavParams?)?.onBack,
          ),
        ),
      ],
    ),
    GoRoute(
      name: Routes.about,
      path: '/about',
      builder: (context, state) => const StaticScreen(
        routeName: Routes.about,
        type: models.PageType.about,
      ),
    ),
    GoRoute(
      name: Routes.disclaimer,
      path: '/disclaimer',
      builder: (context, state) => const StaticScreen(
        routeName: Routes.disclaimer,
        type: models.PageType.disclaimer,
      ),
    ),
    GoRoute(
      name: Routes.policy,
      path: '/policy',
      builder: (context, state) => const StaticScreen(
        routeName: Routes.policy,
        type: models.PageType.policy,
      ),
    ),
    GoRoute(
      name: Routes.terms,
      path: '/terms',
      builder: (context, state) => const StaticScreen(
        routeName: Routes.terms,
        type: models.PageType.terms,
      ),
    ),
  ],
);
