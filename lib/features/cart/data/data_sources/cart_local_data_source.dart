import 'package:shop_project/features/cart/domain/entities/cart_item.dart';

abstract class CartLocalDataSource {
  Future<List<CartItem>> fetchCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
  Future<void> increaseQuantity(String productId);
  Future<void> decreaseQuantity(String productId);
  Future<void> updateQuantity(String productId, String quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource{
  final List<CartItem> _cartItems = [];

  @override
  Future<List<CartItem>> fetchCartItems() async {
    return List.unmodifiable(_cartItems);
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final index = _cartItems.indexWhere((e) => e.productId == item.productId);

    if(index >= 0) {
      final existing = _cartItems[index];
      _cartItems[index] = CartItem(
        productId: existing.productId, 
        name: existing.name, 
        imageUrl: existing.imageUrl, 
        price: existing.price, 
        quantity: existing.quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((e) => e.productId == productId);
  }

  @override
  Future<void> increaseQuantity(String productId) async {
    final index = _cartItems.indexWhere((e) => e.productId == productId);

    if(index >= 0){
      final existing = _cartItems[index];
      _cartItems[index] = existing.copyWith(existing.quantity + 1);
    }
  }

  @override
  Future<void> decreaseQuantity(String productId) async {
    final index = _cartItems.indexWhere((e) => e.productId == productId);
    
    if(index >= 0) {
      final existing = _cartItems[index];

      if(existing.quantity > 1){
        _cartItems[index] = existing.copyWith(existing.quantity - 1);
      } else {
        _cartItems.removeAt(index);
      }
    }
  }

  @override
  Future<void> updateQuantity(String productId, String quantity) async {
    final index = _cartItems.indexWhere((e) => e.productId == productId);

    if(index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        int.parse(quantity)
      );
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}