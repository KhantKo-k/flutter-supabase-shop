import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';

class GetMyOrdersUseCase {
  final OrderRepository repository;

  GetMyOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call(){
    return repository.getMyOrders();
  }
}