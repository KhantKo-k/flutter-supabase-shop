
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemUsecase {
  final CartRepository repository;

  const GetCartItemUsecase({required this.repository});

  Future<List<CartItem>> call(){
    return repository.getCartItems();
  }
}