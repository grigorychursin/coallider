import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';

class HookaCloseButton extends StatelessWidget {
  const HookaCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HookaTapAnimationHandler(
      onTap: () => context.read<HookaNavigator>().pop(),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.transparent,
        child: Icon(Icons.close_rounded),
      ),
    );
  }
}
