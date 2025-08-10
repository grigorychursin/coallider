import 'package:hookaapp/features/components/progress_widget.dart';
import 'package:quiver/core.dart';

class FindNearbyDevicesState extends ProgressState {
  @override
  final bool inProgress;
  final bool areTermsAndPrivacyAccepted;
  final Optional<FindNearbyDevicesErrors> error;
  FindNearbyDevicesState({
    required this.areTermsAndPrivacyAccepted,
    this.inProgress = false,
    this.error = const Optional.absent(),
  });

  FindNearbyDevicesState copyWith({
    bool? inProgress,
    bool? areTermsAndPrivacyAccepted,
    Optional<FindNearbyDevicesErrors>? error,
  }) {
    return FindNearbyDevicesState(
      inProgress: inProgress ?? this.inProgress,
      areTermsAndPrivacyAccepted:
          areTermsAndPrivacyAccepted ?? this.areTermsAndPrivacyAccepted,
      error: error ?? this.error,
    );
  }
}

enum FindNearbyDevicesErrors {
  privacyAndTermsNotAccepted,
  permissionNotGranted,
}
