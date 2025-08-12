import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:coallider/core/app/hooka_app.dart';
import 'package:coallider/core/extensions/dicontainer_ext.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void runHookaApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final diContainer = await DiContainer().initApp();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://93b7900f9d2e7603c75c6e8962a2a01d@o4509252652433408.ingest.us.sentry.io/4509252657348608';
    options.sendDefaultPii = true;
    options.tracesSampleRate = 1.0;
  }, appRunner: () => runApp(SafeArea(child: HookaApp(diContainer: diContainer))));
}
