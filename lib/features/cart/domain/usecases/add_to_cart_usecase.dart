import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository repository;
  const AddToCartUsecase({required this.repository});

  Future<void> call(CartItem item){
    return repository.addToCart(item);
  }
}