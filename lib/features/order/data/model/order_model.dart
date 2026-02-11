
import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';

part 'order_model.g.dart';
@JsonSerializable()
class OrderModel extends OrderEntity{
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.createdAt
  }) : super( 
    id: id,
    userId: userId,
    status: status,
    totalAmount: totalAmount,
    createdAt: createdAt,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
    _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}