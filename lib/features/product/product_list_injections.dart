

import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/product/data/datasource/product_remote_datasource.dart';
import 'package:shop_project/features/product/data/repository/product_repository_impl.dart';
import 'package:shop_project/features/product/domain/repository/product_repository.dart';
import 'package:shop_project/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:shop_project/features/product/domain/usecases/get_product_use_case.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:shop_project/features/product/presentation/cubit/selected_product_cubit.dart';

void injectProductRemoteDataSources(){
  serviceLocator.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(serviceLocator())
  );
}

void injectProductRepositories(){
  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      serviceLocator()
    )
  );
}

void injectProductUseCase(){
  serviceLocator.registerLazySingleton(
    () => GetProductUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetCategoriesUsecase(serviceLocator()),
  );
}

void injectProductBloc(){
  serviceLocator.registerLazySingleton(
    () => ProductListBloc(
      getProducts: serviceLocator(),
      getCategories: serviceLocator(),
    )
  );

  serviceLocator.registerLazySingleton<SelectedProductCubit>(
    () => SelectedProductCubit()
  );
}