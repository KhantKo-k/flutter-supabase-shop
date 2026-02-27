

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/data/datasources/order_remote_datasource.dart';
import 'package:shop_project/features/order/data/model/order_item_model.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';


class OrderRepositoryImpl extends OrderRepository{
  final OrderRemoteDatasource datasource;

  OrderRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> createOrder({
    required double totalAmount,
    required String receiverName,
    required String receiverPhone,
    required String address,
    required String paymentMethod,
    String? description,
  }) async {
      return await on(() async => await datasource.createOrder(
        totalAmount: totalAmount, 
        receiverName: receiverName, 
        receiverPhone: receiverPhone, 
        address: address, 
        paymentMethod: paymentMethod,
        description: description
        ));

  }

  @override
  Future<Either<Failure, void>> addOrderItems({
    required String orderId,
    required List<OrderItemEntity> items,
  }) async {
      final models = items.map((e){
        return OrderItemModel(
          id: '', 
          orderId: orderId, 
          productId: e.productId, 
          productName: e.productName, 
          price: e.price, 
          quantity: e.quantity
        );
      }).toList();

      return await on(() async => await datasource.insertOrderItems(orderId, models));

  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getMyOrders() async {

    return await on(() async => await datasource.getOrders());

  }

  @override
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(
    String orderId,
  ) async {
    return await on(() async => await datasource.getOrderItems(orderId));

  }

  @override
  Future<Either<Failure, void>> deleteOrder( 
    String orderId,
  ) async {
    return await on(() async => await datasource.deleteOrder(orderId));

  }
}