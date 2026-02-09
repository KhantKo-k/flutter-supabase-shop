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
      //appBar: _buildAppBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return _buildCartList(state, context);
        },
      ),
    );
  }

  // AppBar _buildAppBar() {
  //   return AppBar(title: Text('My Cart'));
  // }

  Widget _buildCartList(CartState state, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (_, index) {
              final item = state.items[index];
              return _buildCartItem(item, state, context);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Total: \$${state.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, CartState state, BuildContext context) {
    return ListTile(
      leading: _buildImage(item.imageUrl),

      title: Text(item.name),
      subtitle: _buildQuantitySelector(item, state, context),
      trailing: _buildDelete(context, item),
    );
  }

  Widget _buildImage(String imageUrl) {
    return SizedBox(
      width: 60,
      height: 60,
      child: CachedNetworkImage(imageUrl: imageUrl),
    );
  }

  Widget _buildQuantitySelector(
    CartItem item,
    CartState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\$${item.price}'),
        Row(
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
      ],
    );
  }

  Widget _buildDelete(BuildContext context, CartItem item) {
    return IconButton(
      onPressed: () {
        context.read<CartBloc>().add(RemoveItem(productId: item.productId));
      },
      icon: Icon(Icons.remove, size: 20),
    );
  }
}
