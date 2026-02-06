
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/network/supabase_client.dart';
import 'package:shop_project/features/auth/auth_injections.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/email/email_injections.dart';
import 'package:shop_project/features/product/product_list_injections.dart';

void initServiceLocator(){
  serviceLocator.registerLazySingleton(
    () => SupabaseClientProvider.client,
  );

  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initBlocs();
  _initServices();

  _initAppRouter();
}

void _initDataSources(){
  injectAuthRemoteDataSources();
  injectEmailRemoteDataSources();
  injectProductRemoteDataSources();
}

void _initRepositories(){
  injectAuthRepositories();
  injectEmailRepositories();
  injectProductRepositories();
}

void _initUseCases(){
  injectAuthUseCase();
  injectEmailUseCase();
  injectProductUseCase();
}

void _initBlocs(){
  injectAuthBlocs();
  injectEmailBloc();
  injectProductBloc();
}

void _initServices(){

}

void _initAppRouter(){
  serviceLocator.registerLazySingleton<AppRouter>(
    () => AppRouter(serviceLocator.get<AuthBloc>())
  );
}