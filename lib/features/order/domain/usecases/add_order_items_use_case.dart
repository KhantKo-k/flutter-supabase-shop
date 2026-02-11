import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';

class AddOrderItemsUseCase {
  final OrderRepository repository;

  AddOrderItemsUseCase(this.repository);

  Future<void> call({
    required String orderId,
    required List<OrderItemEntity> items
  }) {
    return repository.addOrderItems(
      orderId: orderId, items: items
    );
  }
}