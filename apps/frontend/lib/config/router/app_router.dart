

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
      builder: (_, state) => const MapsPage( ),
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home',
    ),
  ]
);
