import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class UpdateQuantityUsecase {
  final CartRepository repository;
  const UpdateQuantityUsecase({required this.repository});

  Future<void> call(String productId, String quantity){
    return repository.updateQuantity(productId,quantity);
  }
}