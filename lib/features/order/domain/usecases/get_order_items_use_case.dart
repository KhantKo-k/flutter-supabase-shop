import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';

class GetOrderItemsUseCase {
  final OrderRepository repository;

  GetOrderItemsUseCase(this.repository);

  Future<Either<Failure, List<OrderItemEntity>>> call(
    String orderId
  ){
    return repository.getOrderItems(orderId);
  }
}