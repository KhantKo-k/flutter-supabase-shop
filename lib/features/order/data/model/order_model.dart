
// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';

part 'order_model.g.dart';
@JsonSerializable(includeIfNull: false)
class OrderModel extends OrderEntity{

  @JsonKey(name: 'id')
  final String id;


  @JsonKey(name: 'user_id')
  final String userId;


  @JsonKey(name: 'status')
  final String status;


  @JsonKey(name: 'total_amount', fromJson: _toDouble)
  final double totalAmount;


  @JsonKey(name: 'created_at')
  final DateTime createdAt;


  @JsonKey(name: 'order_display_id')
  final String orderDisplayId;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'payment_method')
  final String paymentMethod;


  @JsonKey(name: 'receiver_name')
  final String receiverName;


  @JsonKey(name: 'receiver_phone')
  final String receiverPhone;


  @JsonKey(name: 'description')
  final String? description;

  const OrderModel({
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
  }) : super( 
    id: id,
    userId: userId,
    status: status,
    totalAmount: totalAmount,
    createdAt: createdAt,
    orderDisplayId: orderDisplayId,
    address: address,
    paymentMethod: paymentMethod,
    receiverName: receiverName,
    receiverPhone: receiverPhone,
    description: description,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
    _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  static double _toDouble(dynamic val) => (val as num).toDouble();
}