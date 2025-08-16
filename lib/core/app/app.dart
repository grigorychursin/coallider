import 'package:coallider/core/theme/app_theme_cubit.dart';
import 'package:coallider/features/ble/app_ble_cubit.dart';
import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/core/services/navigation/app_route_generator.dart';
import 'package:coallider/core/services/navigation/app_routes.dart';
import 'package:coallider/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final DiContainer diContainer;
  const App({super.key, required this.diContainer});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeCubit>(create: (context) => AppThemeCubit()),
        BlocProvider<AppBleCubit>(
          create:
              (context) => AppBleCubit(
                ble: diContainer.resolve(),
                permissionService: diContainer.resolve(),
              ),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return MultiProvider(
            providers: [
              Provider.value(
                value: AppNavigator(navigatorKey: _navigatorKey),
              ),
              Provider<Resolver>.value(value: diContainer),
            ],
            child: MaterialApp(
              themeMode: state.mode,
              themeAnimationCurve: Curves.easeInOut,
              themeAnimationDuration: const Duration(milliseconds: 700),
              theme: AppTheme().light,
              darkTheme: AppTheme().dark,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouteGenerator.onGenerateRoute,
              initialRoute: AppRoutes.home,
              navigatorKey: _navigatorKey,
            ),
          );
        },
      ),
    );
  }
}
