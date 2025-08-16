import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coallider/core/constants/app_images.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_appbar.dart';
import 'package:coallider/features/components/max_size_sroll_view.dart';
import 'package:coallider/features/find_nearby_devices_screen/components/pp_and_tc_widget.dart';
import 'package:coallider/features/find_nearby_devices_screen/cubit.dart';
import 'package:coallider/features/find_nearby_devices_screen/state.dart';

class FindNearbyDevicesScreen extends StatefulWidget {
  const FindNearbyDevicesScreen({super.key});

  @override
  State<FindNearbyDevicesScreen> createState() =>
      _FindNearbyDevicesScreenState();
}

class _FindNearbyDevicesScreenState extends State<FindNearbyDevicesScreen> {
  late final FindNearbyDevicesCubit _cubit;
  bool _isPressed = false;

  @override
  void initState() {
    _cubit = FindNearbyDevicesCubit(
      navigator: context.read(),
      storage: context.resolve(),
      bleCubit: context.read(),
    );
    super.initState();
  }

  void _onTapDown(_) => setState(() => _isPressed = true);
  void _onTapUp(_) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final overlayColor = Colors.white.withOpacity(0.1);
    return Scaffold(
      appBar: thisAppBar(context: context, applyLeading: false),
      body: BlocProvider.value(
        value: _cubit,
        child: BlocConsumer<FindNearbyDevicesCubit, FindNearbyDevicesState>(
          listenWhen: (previous, current) => current.error.isPresent,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(content: Text(_errorText(state.error.value))),
              );
          },
          builder: (context, state) {
            return MaxSizeScrollView(
              child: Column(
                children: [
                  Text(
                    AppTexts.nearbyDevices,
                    style: context.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: context.mediaQuery.size.width - 32,
                    width: context.mediaQuery.size.width - 32,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          context.isLightTheme
                              ? AppImages.nearbyDevicesLight
                              : AppImages.nearbyDevicesDark,
                          fit: BoxFit.cover,
                          width: context.mediaQuery.size.width,
                        ),

                        GestureDetector(
                          onTap: _cubit.onFindDevicesTap,
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTapCancel: _onTapCancel,
                          child: AnimatedOpacity(
                            opacity: _isPressed ? 1 : 0,
                            duration: const Duration(milliseconds: 100),
                            child: Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                color: overlayColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PpAndTcWidget(),
                ],
              ).paddingSymmetric(h: 16.0, v: 24.0),
            );
          },
        ),
      ),
    );
  }
}

String _errorText(FindNearbyDevicesErrors error) {
  switch (error) {
    case FindNearbyDevicesErrors.privacyAndTermsNotAccepted:
      return AppTexts.privacyAndTermsNotAccepted;
    case FindNearbyDevicesErrors.permissionNotGranted:
      return AppTexts.permissionNotGranted;
  }
}
