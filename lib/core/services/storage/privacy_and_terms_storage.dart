import 'package:coallider/core/services/storage/hooka_storage.dart';

class PrivacyAndTermsStorage extends HiveStorage<bool> {
  static const String _boxKey = 'privacy_and_terms_checkbox';

  PrivacyAndTermsStorage() : super(_boxKey);

  Future<void> setAccepted(bool isAccepted) async {
    await put(_boxKey, isAccepted);
  }

  bool isAccepted() {
    return get(_boxKey) ?? false;
  }
}
