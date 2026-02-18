import 'package:equatable/equatable.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

abstract class OrderEvent extends Equatable{
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderRequested extends OrderEvent{
  final List<OrderItemEntity> items;
  final double totalAmount;

  const PlaceOrderRequested({
    required this.items,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [items, totalAmount];
}

class LoadMyOrders extends OrderEvent{}

class LoadOrderItems extends OrderEvent{
  final String orderId;

  const LoadOrderItems(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class DeleteOrder extends OrderEvent{
  final String orderId;
  const DeleteOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
