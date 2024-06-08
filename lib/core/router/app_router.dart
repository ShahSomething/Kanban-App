import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/router/app_routes.dart';
import 'package:kanban/features/counter/counter.dart';
import 'package:kanban/features/navigation/view/navigation_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  // static final GlobalKey<NavigatorState> _shellNavigatorKey =
  //     GlobalKey<NavigatorState>();

  // Getters
  static BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const NavigationPage(),
      ),
      GoRoute(
        name: AppRoutes.counter,
        path: AppRoutes.counter,
        builder: (context, state) {
          return const CounterPage();
        },
      ),
    ],
    debugLogDiagnostics: true,
    navigatorKey: _navigatorKey,
  );
}
