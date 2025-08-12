import 'package:flutter/material.dart';
import 'package:coallider/core/constants/hooka_colors.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/services/navigation/hooka_navigator.dart';
import 'package:coallider/core/services/navigation/hooka_routes.dart';
import 'package:coallider/features/find_nearby_devices_screen/cubit.dart';
import 'package:provider/provider.dart';

class PpAndTcWidget extends StatelessWidget {
  const PpAndTcWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FindNearbyDevicesCubit>();
    final isAccepted = cubit.state.areTermsAndPrivacyAccepted;
    return Row(
      children: [
        Checkbox.adaptive(
          value: isAccepted,
          onChanged: cubit.onPrivacyAndTermsCheckboxTap,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Item(
              plainText: 'Я согласен с',
              highlightedText: ' "Политикой использования"',
              screenPath: HookaRoutes.termsAndConditions,
            ),
            const SizedBox(height: 8),
            _Item(
              plainText: 'и принимаю',
              highlightedText: ' "Политику конфиденциальности"',
              screenPath: HookaRoutes.privacyPolicy,
            ),
          ],
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String plainText;
  final String highlightedText;
  final String screenPath;
  const _Item({
    required this.plainText,
    required this.highlightedText,
    required this.screenPath,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Row(
      children: [
        Text(
          plainText,
          style: textTheme.headlineSmall!.copyWith(
            color: context.isLightTheme ? HookaColors.black : null,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<HookaNavigator>().pushNamed(screenPath);
          },
          child: Text(
            highlightedText,
            style: textTheme.headlineSmall!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
