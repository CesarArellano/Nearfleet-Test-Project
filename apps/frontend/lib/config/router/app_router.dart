

import 'package:go_router/go_router.dart';

import '../../presentation/pages/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/home',
      builder: (_, state) => const HomePage(),
    ),
    GoRoute(
      path: '/maps',
      builder: (_, state) {
        final extra = (state.extra ?? const MapsPageScreenParams().toMap()) as Map<String, dynamic>;
        final screenParams = MapsPageScreenParams.fromMap(extra);

        return MapsPage(screenParams: screenParams);
      }
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home',
    ),
  ]
);
