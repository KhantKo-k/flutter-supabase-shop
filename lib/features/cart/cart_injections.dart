
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:shop_project/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_project/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/decrease_quantity_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/increase_quantity_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/update_quantity_usecase.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';

void injectCartLocalDatasource(){
  serviceLocator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );
}

void injectCartRepository(){
  serviceLocator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(dataSource: serviceLocator())
  );
}

void injectCartUsecase(){
  serviceLocator.registerLazySingleton(
    () => AddToCartUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => DecreaseQuantityUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => GetCartItemUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => IncreaseQuantityUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => RemoveFromCartUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => UpdateQuantityUsecase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => ClearCartUsecase(serviceLocator()),
  );
}

void injectCartBloc(){
  serviceLocator.registerLazySingleton<CartBloc>(
    () => CartBloc(
      addToCart: serviceLocator(), 
      getCartItems: serviceLocator(), 
      removeFromCart: serviceLocator(), 
      increaseQuantity: serviceLocator(), 
      decreaseQuantity: serviceLocator(),
      updateQuantity: serviceLocator(),
      clearCart: serviceLocator(),
    )
  );
}