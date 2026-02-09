

import 'package:shop_project/features/cart/domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  CartState({
    required this.items,
    required this.isLoading,
    this.error
  });

  factory CartState.initial(){
    return CartState(
      items: [], 
      isLoading: false,
      error: null
    );
  }

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? error, 
  }) {
    return CartState(
      items: items ?? this.items, 
      isLoading: isLoading ?? this.isLoading,
      error: error
    );
  }

  double get totalPrice{
    return items.fold(0, 
    (sum, item) => sum + item.price * item.quantity,
    );
  }
}