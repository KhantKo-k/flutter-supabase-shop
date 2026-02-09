
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class IncreaseQuantityUsecase {
  final CartRepository repository;
  const IncreaseQuantityUsecase({required this.repository});

  Future<void> call(String productId){
    return repository.increaseQuantity(productId);
  }
}