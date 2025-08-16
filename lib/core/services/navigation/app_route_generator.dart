import 'package:flutter/material.dart';
import 'package:coallider/core/services/navigation/app_routes.dart';
import 'package:coallider/features/connection_details_screen/screen.dart';
import 'package:coallider/features/find_nearby_devices_screen/screen.dart';
import 'package:coallider/features/found_devices_screen/screen.dart';
import 'package:coallider/features/pp_and_tc/privacy_policy_screen.dart';
import 'package:coallider/features/pp_and_tc/terms_and_conditions_screen.dart';

final class AppRouteGenerator {
  const AppRouteGenerator._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late final Widget route;
    switch (settings.name) {
      case AppRoutes.home:
        route = const FindNearbyDevicesScreen();
        break;
      case AppRoutes.foundDevicesScreen:
        route = const FoundDevicesScreen();
        break;
      case AppRoutes.connectionDetails:
        route = const ConnectionDetailsScreen();
        break;
      case AppRoutes.privacyPolicy:
        route = const PrivacyPolicyScreen();
        break;
      case AppRoutes.termsAndConditions:
        route = const TermsAndConditionsScreen();
        break;
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => route,
      settings: settings,
    );
  }
}
