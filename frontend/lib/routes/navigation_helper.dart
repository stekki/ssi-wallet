import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/landing_screen.dart';
import '../screens/home_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/credential_screen.dart';
import '../widgets/navigation_screen_outline.dart';

class NavigationHelper {
  static final NavigationHelper _instance = NavigationHelper._internal();

  static NavigationHelper get instance => _instance;

  static late final GoRouter router;
/*
  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> chatTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> credentialTabNavigatorKey =
      GlobalKey<NavigatorState>();
*/
  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  factory NavigationHelper() {
    return _instance;
  }

  NavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        //parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            //navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomeScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            //navigatorKey: chatTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'chat',
                path: '/chat',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ChatScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            //navigatorKey: credentialTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'credential',
                path: '/credential',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const CredentialScreen(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: NavigationScreenOutline(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return getPage(
            child: const LandingScreen(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      initialLocation: '/',
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}