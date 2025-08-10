import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/core/services/navigation/hooka_route_generator.dart';
import 'package:hookaapp/core/services/navigation/hooka_routes.dart';
import 'package:hookaapp/core/theme/hooka_theme.dart';
import 'package:hookaapp/core/theme/hooka_theme_cubit.dart';
import 'package:hookaapp/features/hooka_ble/hooka_ble_cubit.dart';
import 'package:provider/provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class HookaApp extends StatelessWidget {
  final DiContainer diContainer;
  const HookaApp({super.key, required this.diContainer});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HookaThemeCubit>(create: (context) => HookaThemeCubit()),
        BlocProvider<HookaBleCubit>(
          create:
              (context) => HookaBleCubit(
                ble: diContainer.resolve(),
                permissionService: diContainer.resolve(),
              ),
        ),
      ],
      child: BlocBuilder<HookaThemeCubit, HookaThemeState>(
        builder: (context, state) {
          return MultiProvider(
            providers: [
              Provider.value(
                value: HookaNavigator(navigatorKey: _navigatorKey),
              ),
              Provider<Resolver>.value(value: diContainer),
            ],
            child: MaterialApp(
              themeMode: state.mode,
              themeAnimationCurve: Curves.easeInOut,
              themeAnimationDuration: const Duration(milliseconds: 700),
              theme: HookaTheme().light,
              darkTheme: HookaTheme().dark,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: HookaRouteGenerator.onGenerateRoute,
              initialRoute: HookaRoutes.home,
              navigatorKey: _navigatorKey,
            ),
          );
        },
      ),
    );
  }
}
