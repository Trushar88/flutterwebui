// ignore_for_file: prefer_const_constructors, unused_field, library_private_types_in_public_api

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebtest/App/Base/base_route.dart';
import 'package:flutterwebtest/App/Common/common_image_widget.dart';

class ImagePage extends BaseRoute {
  final FirebaseAnalytics a;
  final FirebaseAnalyticsObserver o;
  final String url;
  ImagePage({super.key, required this.a, required this.o, required this.url})
      : super(
          routeName: "ImagePage",
          analytics: a,
          observer: o,
        );

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CommonImageWidget(
        imageUrl: widget.url,
        boxFit: BoxFit.fitWidth,
        height: 500,
        width: 500,
      ),
    );
  }
}
