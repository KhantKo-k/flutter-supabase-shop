
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/core/di/service_locator.dart';

void injectAuthLocalStorage(){
  serviceLocator.registerLazySingleton<AuthLocalStorage>(
    () => AuthLocalStorageImpl()
  );
}