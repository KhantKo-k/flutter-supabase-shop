// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  status: json['status'] as String,
  totalAmount: (json['total_amount'] as num).toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
  orderDisplayId: json['order_display_id'] as String,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'created_at': instance.createdAt.toIso8601String(),
      'order_display_id': instance.orderDisplayId,
    };
