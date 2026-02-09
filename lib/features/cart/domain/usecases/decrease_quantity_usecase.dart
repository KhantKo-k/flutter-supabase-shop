import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class DecreaseQuantityUsecase {
  final CartRepository repository;

  const DecreaseQuantityUsecase({required this.repository});

  Future<void> call(String productId){
    return repository.decreaseQuantity(productId);
  }
}