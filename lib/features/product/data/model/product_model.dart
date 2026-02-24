

import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    @JsonKey(defaultValue: '')
    required super.id,

    @JsonKey(defaultValue: '')
    required super.name,

    @JsonKey(defaultValue: '')
    required super.category,

    @JsonKey(defaultValue: '')
    required super.description,

    @JsonKey(fromJson: _priceFromJson)
    required super.price,

    @JsonKey(
      name: 'image_url',
      defaultValue: 'https://via.placeholder.com/300',
    )
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  static double _priceFromJson(dynamic value) =>
      (value as num?)?.toDouble() ?? 0.0;
}


// @JsonSerializable()
// class ProductModel extends Product{
//   const ProductModel({
//     required super.id,
//     required super.name,
//     required super.imageUrl,
//     required super.price,
//     required super.category,
//   });

//   @JsonKey(defaultValue: '')
//   final String id;

//   @JsonKey(defaultValue: '')
//   final String name;

//   @JsonKey(fromJson: _priceFromJson)
//   final double price;

//   @JsonKey(
//     name: 'image_url',
//     defaultValue: 'https://via.placeholder.com/300',
//   )
//   final String imageUrl;

//   static double _priceFromJson(dynamic value) => (value as num?)?.toDouble() ?? 0.0;

//   factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductModelToJson(this);
// }