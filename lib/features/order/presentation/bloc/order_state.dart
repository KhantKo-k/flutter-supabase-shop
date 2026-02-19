

import 'package:equatable/equatable.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

enum OrderStatus{
  initial,
  loading,
  loaded,
  success,
  failure,
}

class OrderState extends Equatable{
  final OrderStatus status;
  final List<OrderEntity> orders;
  final List<OrderItemEntity> orderItems;
  final Failure? failure;
  final String? successOrderId;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.orderItems = const [],
    this.failure,
    this.successOrderId,
  });

  @override
  List<Object?> get props => [status, orders, orderItems, failure, successOrderId];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderEntity>? orders,
    List<OrderItemEntity>? orderItems,
    Failure? failure,
    String? successOrderId,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      orderItems: orderItems ?? this.orderItems,
      failure: failure ?? this.failure,
      successOrderId: successOrderId ?? this.successOrderId,
    );
  }
}