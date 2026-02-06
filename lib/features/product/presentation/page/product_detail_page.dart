import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/common_widgets/category_chip.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/presentation/bloc/product_detail_bloc.dart';
import 'package:shop_project/features/product/presentation/bloc/product_detail_event.dart';
import 'package:shop_project/features/product/presentation/bloc/product_detail_state.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Product Details',            
            ),       
            elevation: 0,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(state.product.imageUrl, context),
                    _buildProductInfo(state.product),
                    _buildQuantitySelector(state, context),
                    SizedBox(height: 100,)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomBar(state),
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
              style: TextStyle(
                fontSize: 16,
                height: 1.5, 
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
    ProductDetailState state,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          children: [
            _qtyButton(
              Icons.remove,
              () => context.read<ProductDetailBloc>().add(QuantityDecreased()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${state.quantity}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _qtyButton(
              Icons.add,
              () => context.read<ProductDetailBloc>().add(QuantityIncreased()),
            ),
            VerticalDivider(),
            // Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price', style: TextStyle(color: Colors.grey)),
                Text(
                  '\$${state.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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

  Widget _buildBottomBar(ProductDetailState state) {
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
