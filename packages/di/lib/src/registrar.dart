abstract class Registrar {
  void registerFactory<T>(Factory<T> factory, {String? name});

  void registerSingleton<T>(T singleton, {String? name});

  void registerLazySingleton<T>(Factory<T> factory, {String? name});

  void unregisterSingleton<T>({String? name});

  void clear();
}

abstract class Resolver {
  T resolve<T>([String? name]);
}

typedef Factory<T> = T Function(Resolver r);
