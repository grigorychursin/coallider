import 'package:hive/hive.dart';

abstract class HiveStorage<T> {
  final String boxName;

  HiveStorage(this.boxName);

  Future<void> init() async {
    await Hive.openBox<T>(boxName);
  }

  Box<T> get box => Hive.box<T>(boxName);

  Future<void> put(String key, T value) async {
    await box.put(key, value);
  }

  T? get(String key) {
    return box.get(key);
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
