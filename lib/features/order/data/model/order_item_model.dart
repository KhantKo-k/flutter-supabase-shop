
import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';

part 'order_item_model.g.dart';
@JsonSerializable()
class OrderItemModel extends OrderItemEntity{
  @override
  @JsonKey(name: 'id')
  final String id;

  @override
  @JsonKey(name: 'order_id')
  final String orderId;

  @override
  @JsonKey(name: 'product_id')
  final String productId;

  @override
  @JsonKey(name: 'product_name')
  final String productName;

  @override
  @JsonKey(name: 'price')
  final double price;

  @override
  @JsonKey(name: 'quantity')
  final int quantity;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity
  }) : super ( 
    id: id,
    orderId: orderId,
    productId: productId,
    productName: productName,
    price: price,
    quantity: quantity
  );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
    _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  Map<String, dynamic> toInsertJson(String orderId){
    return {
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
    };
  }
} 