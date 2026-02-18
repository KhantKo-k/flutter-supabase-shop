import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shop_project/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:shop_project/features/profile/domain/repositories/profile_repository.dart';
import 'package:shop_project/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:shop_project/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_bloc.dart';

void injectProfileRemoteDataSources(){
  serviceLocator.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(serviceLocator())
  );
}

void injectProfileRepositories(){
  serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(serviceLocator())
  );
}

void injectProfileUseCases(){
  serviceLocator.registerLazySingleton(
    () => GetProfileUseCase(serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => UpdateProfileUseCase(serviceLocator())
  );
}

void injectProfileBloc(){
  serviceLocator.registerLazySingleton(
    () => ProfileBloc(
      getMyProfile: serviceLocator(), 
      updateProfile: serviceLocator()
    ),
  );
}