
import 'package:equatable/equatable.dart';

class CartItem extends Equatable{
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  const CartItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith(int? quantity){
    return CartItem(
      productId: productId, 
      name: name, 
      imageUrl: imageUrl, 
      price: price, 
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [ productId, name, imageUrl, price, quantity];
}