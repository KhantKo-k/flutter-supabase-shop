import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUsecase {
  final CartRepository repository;

  ClearCartUsecase(this.repository);

  Future<void> call(){
    return repository.clearCart();
  }
}