// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  category: json['category'] as String? ?? '',
  description: json['description'] as String? ?? '',
  price: (json['price'] as num).toDouble(),
  imageUrl: json['image_url'] as String? ?? 'https://via.placeholder.com/300',
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'price': instance.price,
      'category': instance.category,
      'description': instance.description,
    };
