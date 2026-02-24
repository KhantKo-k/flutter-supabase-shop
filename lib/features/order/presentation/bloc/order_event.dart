import 'package:equatable/equatable.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderRequested extends OrderEvent {
  final List<OrderItemEntity> items;
  final double totalAmount;
  final String receiverName;
  final String receiverPhone;
  final String address;
  final String paymentMethod;
  final String? description;

  const PlaceOrderRequested({
    required this.items,
    required this.totalAmount,
    required this.receiverName,
    required this.receiverPhone,
    required this.address,
    required this.paymentMethod,
    this.description,
  });

  @override
  List<Object?> get props => [
    items,
    totalAmount,
    receiverName,
    receiverPhone,
    address,
    paymentMethod,
    description,
  ];
}

class LoadMyOrders extends OrderEvent {}

class LoadOrderItems extends OrderEvent {
  final String orderId;

  const LoadOrderItems(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class DeleteOrder extends OrderEvent {
  final String orderId;
  const DeleteOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
