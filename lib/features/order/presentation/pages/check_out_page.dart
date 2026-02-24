import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_event.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/presentation/bloc/order_bloc.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> items;
  final double totalAmount;

  const CheckoutPage({
    super.key,
    required this.items,
    required this.totalAmount,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPayment = 'Cash on Delivery';

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Check out")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Receiver Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Note (optional)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Delivery Addresss'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              items: [
                'Cash on Delivery',
                'Credit Card',
                'PayPal',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() {
                _selectedPayment = val!;
              }),
              decoration: const InputDecoration(labelText: 'Payment Method'),
            ),
            const Spacer(),
            BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.status == OrderStatus.success) {
                  context.read<CartBloc>().add(ClearCart());
                  
                  context.read<OrderBloc>().add(LoadMyOrders());
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully!")),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.status == OrderStatus.loading
                      ? null
                      : () => _onPlaceOrder(context),
                  child: state.status == OrderStatus.loading
                      ? const CircularProgressIndicator()
                      : Text('Pay  \$${widget.totalAmount}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPlaceOrder(BuildContext context) {
    if (_addressController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    final orderItems = widget.items
        .map(
          (cartItem) => OrderItemEntity(
            id: '',
            orderId: '',
            productId: cartItem.productId,
            productName: cartItem.name,
            price: cartItem.price,
            quantity: cartItem.quantity,
          ),
        )
        .toList();

    context.read<OrderBloc>().add(
      PlaceOrderRequested(
        items: orderItems,
        totalAmount: widget.totalAmount,
        address: _addressController.text.trim(),
        receiverName: _nameController.text.trim(),
        receiverPhone: _phoneController.text.trim(),
        paymentMethod: _selectedPayment,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      ),
    );
  }
}