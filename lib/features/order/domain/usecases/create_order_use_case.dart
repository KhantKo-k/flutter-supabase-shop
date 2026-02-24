
import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required double totalAmount,
    required String receiverName,
    required String receiverPhone,
    required String address,
    required String paymentMethod,
    String? description,
  }) {
    return repository.createOrder(
      totalAmount: totalAmount,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
      address: address,
      paymentMethod: paymentMethod,
      description: description,
    );
  }
}