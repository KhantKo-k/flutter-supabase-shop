import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/common_widgets/category_chip.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_event.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_state.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}
class _ProductDetailPageState extends State<ProductDetailPage>{
  int localQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItemIdex = state.items.indexWhere(
          (item) => item.productId == widget.product.id,
        );
        final bool isInCart = cartItemIdex != -1;
        
        final int displayQuantity = isInCart
          ? state.items[cartItemIdex].quantity
          : localQuantity;

        return Scaffold(
          appBar: AppBar(title: Text('Product Details'), elevation: 0),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(widget.product.imageUrl, context),
                    _buildProductInfo(widget.product),
                    _buildQuantitySelector(isInCart, displayQuantity, context),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: !isInCart ?
                _buildBottomBar(isInCart, displayQuantity, context)
                : SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductImage(String imageUrl, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
              top: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
              top: Radius.circular(32),
            ),
            child: Image.network(
              imageUrl,
              height: MediaQuery.sizeOf(context).height * 0.33,
              width: MediaQuery.sizeOf(context).width * 0.9,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(Product product) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryChip(category: product.category),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.5,
            child: Text(
              product.description,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
    bool isInCart,
    int quantity,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            _qtyButton(Icons.remove, () {
              if (isInCart) {
                // Control global CartBloc
                context.read<CartBloc>().add(DecreaseQuantity(productId: widget.product.id));
              } else {
                // Control local state
                if (localQuantity > 1) setState(() => localQuantity--);
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '$quantity',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _qtyButton(Icons.add, () {
              if (isInCart) {
                // Control global CartBloc
                context.read<CartBloc>().add(IncreaseQuantity(productId: widget.product.id));
              } else {
                // Control local state
                setState(() => localQuantity++);
              }
            }),
            VerticalDivider(),
            // Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price', style: TextStyle(color: Colors.grey)),
                Text(
                  '\$${(widget.product.price * quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
      splashRadius: 24,
    );
  }

  Widget _buildBottomBar(bool isInCart, int quantity, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(
                  AddItem(
                    item: CartItem(
                      productId: widget.product.id,
                      name: widget.product.name,
                      imageUrl: widget.product.imageUrl,
                      price: widget.product.price,
                      quantity: quantity,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
