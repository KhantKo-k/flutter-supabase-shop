
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/auth/data/password/datasource/auth_remote_data_source.dart';
import 'package:shop_project/features/auth/data/password/repositories/auth_repository_impl.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';
import 'package:shop_project/features/auth/domain/password/usecases/login_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/logout_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/sign_up_use_case.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';

void injectAuthRemoteDataSources(){
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator(),
    )
  );
}

void injectAuthRepositories(){
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    )
  );
}

void injectAuthUseCase(){
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => SignUpUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => LogoutUseCase(repository: serviceLocator()),
  );
}

void injectAuthBlocs() {
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: serviceLocator(), 
      signUpUseCase: serviceLocator(), 
      logoutUseCase: serviceLocator(),
      authLocalStorage: serviceLocator(),
      
    ),
  );
}