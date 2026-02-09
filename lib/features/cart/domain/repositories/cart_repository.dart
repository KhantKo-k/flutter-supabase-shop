import 'package:shop_project/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
  Future<void> increaseQuantity(String productId);
  Future<void> decreaseQuantity(String productId);
  Future<void> clearCart();
}