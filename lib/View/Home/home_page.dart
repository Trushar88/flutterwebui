// ignore_for_file: prefer_const_constructors, unused_field, library_private_types_in_public_api

import 'dart:math' as math;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebtest/App/Base/base_route.dart';
import 'package:flutterwebtest/App/Common/common_button_widget.dart';
import 'package:flutterwebtest/App/Common/common_image_widget.dart';
import 'package:flutterwebtest/App/Constant/assets_const.dart';
import 'package:flutterwebtest/App/Constant/color_const.dart';
import 'package:flutterwebtest/App/Extensions/uicontext.dart';
import 'package:flutterwebtest/Models/category_model.dart';
import 'package:flutterwebtest/Routes/routes_endpoints.dart';
import 'package:flutterwebtest/View/Home/HomeBloc/home_bloc.dart';
import 'package:flutterwebtest/View/Home/HomeBloc/home_event.dart';
import 'package:flutterwebtest/View/Home/HomeBloc/home_state.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends BaseRoute {
  final FirebaseAnalytics a;
  final FirebaseAnalyticsObserver o;
  const HomePage({super.key, required this.a, required this.o})
      : super(
          routeName: "HomePage",
          analytics: a,
          observer: o,
        );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  final double _scrollPosition = 0;
  final double _opacity = 0;
  final HomeBloc homeBloc = HomeBloc();

  final List<CategoryModel> _categories = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    homeBloc.context = context;
    homeBloc.add(HomeInitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToImageAddState) {
          context.goNamed(RoutesName.loginScreenName);

          // context.goNamed(RoutesName.imageScreenName, pathParameters: {'imageurl': state.url ?? ""});
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoading:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case HomeLoaded:
            return Scaffold(
                extendBodyBehindAppBar: true,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height / 2 - 80,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1484950763426-56b5bf172dbb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height / 30, horizontal: width / 20),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[100]!,
                                            spreadRadius: -5,
                                            blurRadius: 15,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        AppAssets.LogoOnlyPng,
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    RichText(
                                        text: TextSpan(text: "Snap", style: TextStyle(color: Colors.white), children: const [
                                      TextSpan(text: "G", style: TextStyle(color: Colors.blue, fontSize: 22)),
                                      TextSpan(text: "T", style: TextStyle(color: Colors.lime)),
                                    ])),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    width > 800
                                        ? Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Search here by tag.....',
                                                filled: true,
                                                fillColor: Colors.blueGrey[50],
                                                labelStyle: const TextStyle(fontSize: 12),
                                                contentPadding: const EdgeInsets.only(left: 30),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                suffixIcon: Icon(Icons.search),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    width > 800
                                        ? Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Login",
                                                style: context.customSemiBold(Colors.white, 18),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Signup",
                                                style: context.customSemiBold(Colors.white, 18),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              BouncingButton(
                                                onPress: () {},
                                                textColor: Colors.white,
                                                hoverTextColor: Colors.cyanAccent,
                                                text: "Join",
                                                radiusColor: Colors.cyanAccent,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              BouncingButton(
                                                onPress: () {
                                                  homeBloc.add(HomeUploadClick());
                                                },
                                                text: "Upload",
                                                textColor: Colors.white,
                                                hoverTextColor: Colors.lime,
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            width > 800
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 30),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search here by tag.....',
                                        filled: true,
                                        fillColor: Colors.blueGrey[50],
                                        labelStyle: const TextStyle(fontSize: 12),
                                        contentPadding: const EdgeInsets.only(left: 30),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        suffixIcon: Icon(Icons.search),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 45,
                            ),
                            width < 400
                                ? SizedBox()
                                : Center(
                                    child: Text(
                                      "Here you can explore your imagination",
                                      style: GoogleFonts.aboreto(
                                        color: Colors.white,
                                        fontSize: width < 600 ? 15 : 22,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            width < 400
                                ? SizedBox()
                                : Center(
                                    child: Text(
                                      "Design By : Trushar Mistry",
                                      style: GoogleFonts.aboreto(
                                        color: Colors.white,
                                        fontSize: width < 600 ? 15 : 22,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (state is HomeLoaded)
                        state.categoryList!.isNotEmpty
                            ? Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(horizontal: width / 10),
                                color: AppColor.whiteColor,
                                child: Center(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.categoryList!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(5),
                                          child: BouncingButton(
                                            onPress: () {},
                                            height: 40,
                                            text: state.categoryList![index].name,
                                            textColor: Colors.white,
                                            hoverTextColor: Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
                                          ),
                                        );
                                      }),
                                ),
                              )
                            : SizedBox(),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 10),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: width < 600
                                  ? 2
                                  : width < 1200
                                      ? 3
                                      : 4,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.lime[100]!,
                                        spreadRadius: -2,
                                        blurRadius: 15,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonImageWidget(
                                      imageUrl: "https://images.unsplash.com/photo-1484950763426-56b5bf172dbb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                      width: width,
                                      height: height,
                                      boxFit: BoxFit.contain,
                                      radius: 15,
                                    ),
                                  ));
                            }),
                      )
                    ],
                  ),
                ));
          case HomeError:
            return Scaffold(body: Center(child: Text('Error')));
          default:
            return SizedBox();
        }
      },
    );
  }
}
