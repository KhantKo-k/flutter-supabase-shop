
import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';

part 'order_model.g.dart';
@JsonSerializable()
class OrderModel extends OrderEntity{
  @override
  @JsonKey(name: 'id')
  final String id;

  @override
  @JsonKey(name: 'user_id')
  final String userId;

  @override
  @JsonKey(name: 'status')
  final String status;

  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  @JsonKey(name: 'order_display_id')
  final String orderDisplayId;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.orderDisplayId,
  }) : super( 
    id: id,
    userId: userId,
    status: status,
    totalAmount: totalAmount,
    createdAt: createdAt,
    orderDisplayId: orderDisplayId,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
    _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}