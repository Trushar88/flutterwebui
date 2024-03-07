import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutterwebtest/App/Constant/assets_const.dart';
import 'package:flutterwebtest/Routes/routes_config.dart';
import 'package:flutterwebtest/firebase_options.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Lottie.asset(
              AppAssets.LOTTIE,
              height: 70,
              width: 70,
              animate: true,
            ),
          ),
        );
      },
      child: MaterialApp.router(
        routerConfig: RouteConfig().router,
        title: 'Trushar',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
