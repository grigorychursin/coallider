import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/core/services/navigation/app_routes.dart';
import 'package:coallider/core/services/storage/privacy_and_terms_storage.dart';
import 'package:coallider/data/ble_exceptions.dart';
import 'package:coallider/features/find_nearby_devices_screen/state.dart';
import 'package:coallider/features/ble/app_ble_cubit.dart';
import 'package:quiver/core.dart';

class FindNearbyDevicesCubit extends Cubit<FindNearbyDevicesState> {
  final AppNavigator _navigator;
  final PrivacyAndTermsStorage _storage;
  final AppBleCubit _bleCubit;
  FindNearbyDevicesCubit({
    required final AppNavigator navigator,
    required PrivacyAndTermsStorage storage,
    required AppBleCubit bleCubit,
  }) : _storage = storage,
       _navigator = navigator,
       _bleCubit = bleCubit,
       super(_buildInitialState(storage));

  void onFindDevicesTap() async {
    try {
      emit(state.copyWith(error: Optional.absent()));
      if (state.areTermsAndPrivacyAccepted) {
        await _bleCubit.stopScan();
        await _bleCubit.findDevices();
        await _navigator.pushNamed(AppRoutes.foundDevicesScreen);
      } else {
        emit(
          state.copyWith(
            error: Optional.of(
              FindNearbyDevicesErrors.privacyAndTermsNotAccepted,
            ),
          ),
        );
      }
    } on BlePermissionException catch (_) {
      emit(
        state.copyWith(
          error: Optional.of(FindNearbyDevicesErrors.permissionNotGranted),
        ),
      );
    }
  }

  void onPrivacyAndTermsCheckboxTap(bool? isAccpeted) async {
    emit(
      state.copyWith(
        areTermsAndPrivacyAccepted: isAccpeted,
        error: Optional.absent(),
      ),
    );
    await _storage.setAccepted(isAccpeted ?? false);
  }
}

FindNearbyDevicesState _buildInitialState(PrivacyAndTermsStorage storage) {
  return FindNearbyDevicesState(
    areTermsAndPrivacyAccepted: storage.isAccepted(),
  );
}
