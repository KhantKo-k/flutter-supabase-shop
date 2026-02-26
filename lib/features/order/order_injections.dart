

import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/order/data/datasources/order_remote_datasource.dart';
import 'package:shop_project/features/order/data/repositories/order_repository_impl.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';
import 'package:shop_project/features/order/domain/usecases/add_order_items_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/create_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/delete_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_my_orders_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_order_items_use_case.dart';
import 'package:shop_project/features/order/presentation/bloc/order_bloc.dart';
import 'package:shop_project/features/order/presentation/cubit/address_cubit.dart';

void injectOrderRemoteDatasources(){
  serviceLocator.registerLazySingleton<OrderRemoteDatasource>(
    () => OrderRemoteDatasourceImpl(serviceLocator())
  );
}

void injectOrderRepositories(){
  serviceLocator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(serviceLocator())
  );
}

void injectOrderUseCase(){
  serviceLocator.registerLazySingleton(
    () => AddOrderItemsUseCase(serviceLocator())
  );

  serviceLocator.registerLazySingleton(
    () => CreateOrderUseCase(serviceLocator())
  );

  serviceLocator.registerLazySingleton(
    () => GetMyOrdersUseCase(serviceLocator())
  );

  serviceLocator.registerLazySingleton(
    () => GetOrderItemsUseCase(serviceLocator())
  );

  serviceLocator.registerLazySingleton(
    () => DeleteOrderUseCase(serviceLocator())
  );
}

void injectOrderBloc(){
  serviceLocator.registerLazySingleton(
    () => OrderBloc(
      addOrderItems: serviceLocator(), 
      createOrder: serviceLocator(), 
      getMyOrders: serviceLocator(), 
      getOrderItems: serviceLocator(),
      deleteOrder: serviceLocator(),
    )
  );
  serviceLocator.registerFactory(
    () => AddressCubit(
      serviceLocator()
    )
  );
}