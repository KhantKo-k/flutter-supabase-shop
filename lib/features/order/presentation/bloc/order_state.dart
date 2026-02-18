// import 'package:equatable/equatable.dart';
// import 'package:shop_project/features/order/domain/entity/order_entity.dart';
// import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

// abstract class OrderState extends Equatable{
//   const OrderState();

//   @override
//   List<Object?> get props => [];
// }

// class OrderInitial extends OrderState{}

// class OrderLoading extends OrderState{}

// class OrderPlacedSuccess extends OrderState{
//   final String orderId;

//   const OrderPlacedSuccess(this.orderId);

//   @override
//   List<Object?> get props => [orderId];
// }

// class OrdersLoaded extends OrderState{
//   final List<OrderEntity> orders;
//   const OrdersLoaded(this.orders);

//   @override
//   List<Object?> get props => [orders];
// }

// class OrderItemsLoaded extends OrderState{
//   final List<OrderItemEntity> items;

//   const OrderItemsLoaded(this.items);

//   @override
//   List<Object?> get props => [items];
// }

// class OrderFailure extends OrderState{
//   final String message;
//   const OrderFailure(this.message);

//   @override
//   List<Object?> get props => [message];
// }


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