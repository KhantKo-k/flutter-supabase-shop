import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder({
    required double totalAmount,
    required String receiverName,
    required String receiverPhone,
    required String address,
    required String paymentMethod,
    String? description,
  });

  Future<Either<Failure, void>> addOrderItems({
    required String orderId,
    required List<OrderItemEntity> items,
  });

  Future<Either<Failure, List<OrderEntity>>> getMyOrders();

  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems( 
    String orderId,
  );

  Future<Either<Failure, void>> deleteOrder( 
    String orderId,
  );
}