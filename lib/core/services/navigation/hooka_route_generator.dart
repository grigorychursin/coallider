import 'package:flutter/material.dart';
import 'package:hookaapp/core/services/navigation/hooka_routes.dart';
import 'package:hookaapp/features/connection_details_screen/screen.dart';
import 'package:hookaapp/features/find_nearby_devices_screen/screen.dart';
import 'package:hookaapp/features/found_devices_screen/screen.dart';
import 'package:hookaapp/features/pp_and_tc/privacy_policy_screen.dart';
import 'package:hookaapp/features/pp_and_tc/terms_and_conditions_screen.dart';

final class HookaRouteGenerator {
  const HookaRouteGenerator._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late final Widget route;
    switch (settings.name) {
      case HookaRoutes.home:
        route = const FindNearbyDevicesScreen();
        break;
      case HookaRoutes.foundDevicesScreen:
        route = const FoundDevicesScreen();
        break;
      case HookaRoutes.connectionDetails:
        route = const ConnectionDetailsScreen();
        break;
      case HookaRoutes.privacyPolicy:
        route = const PrivacyPolicyScreen();
        break;
      case HookaRoutes.termsAndConditions:
        route = const TermsAndConditionsScreen();
        break;
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => route,
      settings: settings,
    );
  }
}
