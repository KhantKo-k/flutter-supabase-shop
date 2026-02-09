import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_event.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return _buildEmptyCart();
          }
          return _buildCartList(state, context);
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80),
          const SizedBox(height: 16),
          const Text('Your cart is Empty'),
        ],
      ),
    );
  }

  Widget _buildCartList(CartState state, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final item = state.items[index];
              return _buildCartItem(item, state, context);
            },
          ),
        ),

        _buildCheckoutSection(state),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, CartState state, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildImage(item.imageUrl),
            SizedBox(width: 16),
            _buildDetail(item, context),
            _buildDelete(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        width: 80,
        height: 80,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDetail(CartItem item, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text('\$${item.price}'),
          const SizedBox(height: 8),
          _buildQuantitySelector(item, context),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(CartItem item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                      DecreaseQuantity(productId: item.productId),
                    );
                  },
                  icon: Icon(Icons.remove, size: 20),
                ),

                Text(item.quantity.toString()),

                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                      IncreaseQuantity(productId: item.productId),
                    );
                  },
                  icon: Icon(Icons.add, size: 20),
                ),
              ],
            ),
          ),
          Text('\$${item.quantity * item.price}'),
        ],
      ),
    );
  }

  Widget _buildDelete(BuildContext context, CartItem item) {
    return IconButton(
      onPressed: () {
        context.read<CartBloc>().add(RemoveItem(productId: item.productId));
      },
      icon: Icon(Icons.delete, size: 20),
    );
  }

  Widget _buildCheckoutSection(CartState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 18)),
              Text(
                '\$${state.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Order Now'),
            ),
          ),
        ],
      ),
    );
  }
}
