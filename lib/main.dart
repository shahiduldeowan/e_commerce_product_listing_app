import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show configureDependencies, LoggerServiceImpl;
import 'package:e_ommerce_product_listing_app/app.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies().then((_) {
    LoggerServiceImpl.debugEnabled = true;
    runApp(const App());
    FlutterNativeSplash.remove();
  });
}
