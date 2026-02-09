import 'package:shop_project/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository{
  final CartLocalDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  Future<List<CartItem>> getCartItems() async {
    return dataSource.fetchCartItems();
  }

  @override
  Future<void> addToCart(CartItem item) async {
    return dataSource.addToCart(item);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    return dataSource.removeFromCart(productId);
  }

  @override
  Future<void> increaseQuantity(String productId) async {
    return dataSource.increaseQuantity(productId);
  }

  @override
  Future<void> decreaseQuantity(String productId) async {
    return dataSource.decreaseQuantity(productId);
  }

  @override
  Future<void> clearCart() async {
    return dataSource.clearCart();
  }
}