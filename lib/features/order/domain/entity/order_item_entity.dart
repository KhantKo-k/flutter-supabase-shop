import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable{
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final double price;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, orderId, productId, productName, price, quantity];
}