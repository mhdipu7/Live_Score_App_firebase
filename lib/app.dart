import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:live_football_score/core/app_route.dart';
import 'package:live_football_score/core/dependency_injection.dart';

class LiveFootballScore extends StatefulWidget {
  const LiveFootballScore({super.key});

  @override
  State<LiveFootballScore> createState() => _LiveFootballScoreState();
}

class _LiveFootballScoreState extends State<LiveFootballScore> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp.router(
      routerDelegate: AppRoute.router.routerDelegate,
      routeInformationParser: AppRoute.router.routeInformationParser,
      routeInformationProvider: AppRoute.router.routeInformationProvider,
      initialBinding: DependencyInjection(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.brown,
      ),
    );
  }
}
