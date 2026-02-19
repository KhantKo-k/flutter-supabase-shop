import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable{
  final String id;
  final String userId;
  final String status;
  final double totalAmount;
  final DateTime createdAt;
  final String orderDisplayId;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.orderDisplayId,
  });

  @override
  List<Object?> get props => [id, userId, status, totalAmount, createdAt, orderDisplayId];
}