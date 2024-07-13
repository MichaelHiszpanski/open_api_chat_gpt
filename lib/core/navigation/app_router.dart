import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/presentation/chat_gpt_screen.dart';
import 'package:open_api_chat_gpt/feature/results/presentation/results_screem.dart';
import 'package:open_api_chat_gpt/feature/splash/presentation/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: ChatGPTRoute.page),
        AutoRoute(page: ResultsRoute.page),
      ];
}
