import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTapAnimationHandler(
      onTap: () => context.read<AppNavigator>().pop(),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.transparent,
        child: Icon(Icons.close_rounded),
      ),
    );
  }
}
