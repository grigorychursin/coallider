import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/core/services/navigation/hooka_routes.dart';
import 'package:hookaapp/core/services/storage/privacy_and_terms_storage.dart';
import 'package:hookaapp/data/ble_exceptions.dart';
import 'package:hookaapp/features/find_nearby_devices_screen/state.dart';
import 'package:hookaapp/features/hooka_ble/hooka_ble_cubit.dart';
import 'package:quiver/core.dart';

class FindNearbyDevicesCubit extends Cubit<FindNearbyDevicesState> {
  final HookaNavigator _navigator;
  final PrivacyAndTermsStorage _storage;
  final HookaBleCubit _bleCubit;
  FindNearbyDevicesCubit({
    required final HookaNavigator navigator,
    required PrivacyAndTermsStorage storage,
    required HookaBleCubit bleCubit,
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
        await _navigator.pushNamed(HookaRoutes.foundDevicesScreen);
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
