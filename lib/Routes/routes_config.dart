import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebtest/Routes/routes_endpoints.dart';
import 'package:flutterwebtest/View/Error/error_page.dart';
import 'package:flutterwebtest/View/Home/home_page.dart';
import 'package:flutterwebtest/View/Image/image_page.dart';
import 'package:flutterwebtest/View/Login/login_page.dart';
import 'package:go_router/go_router.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class RouteConfig {
  GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RoutesPath.initRoutePath,
      observers: [observer],
      routes: [
        GoRoute(
          path: RoutesPath.initRoutePath,
          name: RoutesName.initRouteName,
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
            child: HomePage(
              a: analytics,
              o: observer,
            ),
          ),
        ),
        GoRoute(
          path: RoutesPath.loginScreenPath,
          name: RoutesName.loginScreenName,
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
            child: LoginPage(
              a: analytics,
              o: observer,
            ),
          ),
        ),
        GoRoute(
          path: "${RoutesPath.imageScreenPath}/:imageurl",
          name: RoutesName.imageScreenName,
          pageBuilder: (BuildContext context, state) => MaterialPage(
            child: ImagePage(
              a: analytics,
              o: observer,
              url: state.pathParameters['imageurl'] ?? "",
            ),
          ),
        ),
      ],
      errorPageBuilder: ((context, state) {
        return const MaterialPage(child: ErrorPage());
      }));
}
