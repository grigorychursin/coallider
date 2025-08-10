import 'package:di/src/registrar.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class DiContainer implements Registrar, Resolver {
  final _container = kiwi.KiwiContainer.scoped();
  DiContainer._internal();
  static DiContainer? instance;
  factory DiContainer() {
    instance ??= DiContainer._internal();
    return instance!;
  }
  @override
  void registerFactory<T>(Factory<T> factory, {String? name}) {
    _container.registerFactory((c) => factory(this), name: name);
  }

  @override
  void registerLazySingleton<T>(Factory<T> factory, {String? name}) {
    _container.registerSingleton((c) => factory(this), name: name);
  }

  @override
  void registerSingleton<T>(T singleton, {String? name}) {
    _container.registerInstance(singleton, name: name);
  }

  @override
  void unregisterSingleton<T>({String? name}) {
    _container.unregister<T>(name);
  }

  @override
  T resolve<T>([String? name]) => _container.resolve(name);

  @override
  void clear() {
    _container.clear();
  }
}
