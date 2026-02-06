
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/auth/data/email/datasource/email_remote_datasource.dart';
import 'package:shop_project/features/auth/data/email/repositories/email_repository_impl.dart';
import 'package:shop_project/features/auth/domain/email/repository/email_repository.dart';
import 'package:shop_project/features/auth/domain/email/usecases/check_email_use_case.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_bloc.dart';

void injectEmailRemoteDataSources(){
  serviceLocator.registerLazySingleton<EmailRemoteDatasource>(
    () => EmailRemoteDatasourceImpl(serviceLocator()),
  );
}

void injectEmailRepositories(){
  serviceLocator.registerLazySingleton<EmailRepository>(
    () => EmailRepositoryImpl(serviceLocator()),
  );
}

void injectEmailUseCase(){
  serviceLocator.registerLazySingleton(
    () => CheckEmailUseCase(serviceLocator()),
  );
}

void injectEmailBloc(){
  serviceLocator.registerLazySingleton(
    () => EmailBloc(
      checkEmailUseCase:  serviceLocator()
    )
  );
}