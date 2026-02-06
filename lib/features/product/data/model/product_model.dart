

import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    @JsonKey(defaultValue: '')
    required String id,

    @JsonKey(defaultValue: '')
    required String name,

    @JsonKey(defaultValue: '')
    required String category,

    @JsonKey(defaultValue: '')
    required String description,

    @JsonKey(fromJson: _priceFromJson)
    required double price,

    @JsonKey(
      name: 'image_url',
      defaultValue: 'https://via.placeholder.com/300',
    )
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          price: price,
          imageUrl: imageUrl,
          category: category,
          description: description,
        );

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