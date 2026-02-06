import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, imageUrl, price, category, description];
}