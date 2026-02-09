import 'package:shop_project/features/cart/domain/entities/cart_item.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent{}

class AddItem extends CartEvent{
  final CartItem item;
  AddItem({required this.item});
}

class RemoveItem extends CartEvent{
  final String productId;
  RemoveItem({required this.productId});
}

class ClearCart extends CartEvent{}

class IncreaseQuantity extends CartEvent{
  final String productId;

  IncreaseQuantity({required this.productId});
}

class DecreaseQuantity extends CartEvent{
  final String productId;

  DecreaseQuantity({required this.productId});
}

class UpdateQuantity extends CartEvent{
  final String quantity;

  UpdateQuantity({required this.quantity});
}

