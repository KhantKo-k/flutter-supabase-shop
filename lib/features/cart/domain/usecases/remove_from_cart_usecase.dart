
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUsecase {
  final CartRepository repository;
  const RemoveFromCartUsecase({required this.repository});

  Future<void> call(String productId){
    return repository.removeFromCart(productId);
  }
}