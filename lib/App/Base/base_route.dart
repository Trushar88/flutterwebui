// ignore_for_file: must_be_immutable

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebtest/Routes/routes_config.dart';

class BaseRoute extends StatefulWidget {
  final String routeName;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const BaseRoute({super.key, required this.routeName, required this.analytics, required this.observer});

  @override
  State<BaseRoute> createState() => _BaseRoute();
}

class _BaseRoute extends State<BaseRoute> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void didUpdateWidget(covariant BaseRoute oldWidget) {
    setScreen();
    super.didUpdateWidget(oldWidget);
  }

  void setScreen() {
    analytics.logScreenView();
  }
}
