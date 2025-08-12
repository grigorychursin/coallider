import 'package:coallider/core/services/storage/hooka_storage.dart';

class PermissionErrorCountStorage extends HiveStorage<int> {
  static const String _boxKey = 'permission_error_count';

  PermissionErrorCountStorage() : super(_boxKey);

  Future<void> setCount(int count) async {
    await put(_boxKey, count);
  }

  int getErrorsCount() {
    return get(_boxKey) ?? 0;
  }
}
