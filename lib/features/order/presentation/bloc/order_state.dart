import 'package:equatable/equatable.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

abstract class OrderState extends Equatable{
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState{}

class OrderLoading extends OrderState{}

class OrderPlacedSuccess extends OrderState{
  final String orderId;

  const OrderPlacedSuccess(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class OrdersLoaded extends OrderState{
  final List<OrderEntity> orders;
  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderItemsLoaded extends OrderState{
  final List<OrderItemEntity> items;

  const OrderItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class OrderFailure extends OrderState{
  final String message;
  const OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}