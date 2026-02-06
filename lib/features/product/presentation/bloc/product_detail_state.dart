import 'package:equatable/equatable.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

class ProductDetailState extends Equatable{
  final Product product;
  final int quantity;

  const ProductDetailState({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
  
  ProductDetailState copyWith({int? quantity}){
    return ProductDetailState(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }



  @override
  List<Object> get props => [product, quantity];
}