import 'package:e_ommerce_product_listing_app/core/configs/app_configs.dart';
import 'package:e_ommerce_product_listing_app/core/constants/route_names.dart';
import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show AppRoutes, AppThemes, navigationService;
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfigs.appName,
      debugShowCheckedModeBanner: AppConfigs.debugShowCheckedModeBanner,
      themeMode: AppConfigs.themeMode,
      theme: AppThemes.lightTheme(),
      navigatorKey: navigationService.navigatorKey,
      initialRoute: RouteNames.initialPageRouteName,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
