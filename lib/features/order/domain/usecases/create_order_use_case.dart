
import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, String>> call(double totalAmount) {
    return repository.createOrder(totalAmount: totalAmount);
  }
}