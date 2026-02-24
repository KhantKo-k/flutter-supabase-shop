import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String status;
  final double totalAmount;
  final DateTime createdAt;
  final String orderDisplayId;
  final String address;
  final String paymentMethod;
  final String receiverName;
  final String receiverPhone;
  final String? description;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.orderDisplayId,
    required this.address,
    required this.paymentMethod,
    required this.receiverName,
    required this.receiverPhone,
    this.description,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    status,
    totalAmount,
    createdAt,
    orderDisplayId,
    address,
    paymentMethod,
    receiverName,
    receiverPhone,
    description,
  ];
}
