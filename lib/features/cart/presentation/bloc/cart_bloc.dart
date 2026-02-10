

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/decrease_quantity_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/increase_quantity_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:shop_project/features/cart/domain/usecases/update_quantity_usecase.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_event.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  final AddToCartUsecase addToCart;
  final GetCartItemUsecase getCartItems;
  final RemoveFromCartUsecase removeFromCart;
  final IncreaseQuantityUsecase increaseQuantity;
  final DecreaseQuantityUsecase decreaseQuantity;
  final UpdateQuantityUsecase updateQuantity;

  CartBloc({
    required this.addToCart,
    required this.getCartItems,
    required this.removeFromCart,
    required this.increaseQuantity,
    required this.decreaseQuantity,
    required this.updateQuantity,
  }) : super(CartState.initial()) {
    on<AddItem>(_addToCart);
    on<LoadCart>(_loadCart);
    on<RemoveItem>(_removeFromCart);
    on<IncreaseQuantity>(_increaseQuantity);
    on<DecreaseQuantity>(_decreaseQuantity);
    on<UpdateQuantity>(_updateQuantity);
  }

  Future<void> _addToCart(AddItem event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    try{
      await Future.delayed(const Duration(milliseconds: 800));
      await addToCart(event.item);
      final items = await getCartItems();
      
      emit(state.copyWith(isLoading: false, items: items, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _loadCart(LoadCart event, Emitter<CartState> emit)async{
    emit(state.copyWith(isLoading: true));
    try{
      final items = await getCartItems();
      emit(state.copyWith(items: items, isLoading: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _removeFromCart(RemoveItem event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    try{
      await removeFromCart(event.productId);
      final items = await getCartItems();

      emit(state.copyWith(isLoading: false, items: items, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _increaseQuantity( 
    IncreaseQuantity event,
    Emitter<CartState> emit
  ) async {
    emit(state.copyWith(isLoading: true));
    try{
      await increaseQuantity(event.productId);
      final items = await getCartItems();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _decreaseQuantity( 
    DecreaseQuantity event,
    Emitter<CartState> emit
  ) async {
    emit(state.copyWith(isLoading: true));
    try{
      await decreaseQuantity(event.productId);
      final items = await getCartItems();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _updateQuantity( 
    UpdateQuantity event,
    Emitter<CartState> emit
  ) async {
    emit(state.copyWith(isLoading: true));
    try{
      await Future.delayed(const Duration(milliseconds: 800));

      await updateQuantity(event.productId, event.quantity);
      final items = await getCartItems();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}