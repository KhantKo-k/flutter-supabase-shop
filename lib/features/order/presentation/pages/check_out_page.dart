import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_event.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/presentation/bloc/order_bloc.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';
import 'package:shop_project/features/order/presentation/cubit/address_cubit.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _houseNoController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedPayment = 'Cash on Delivery';

  @override
  void dispose() {
    _houseNoController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AddressCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Check out")),
        body: Builder(
          builder: (context) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Contact Details"),
                    _buildReceiverNameField(),
                    const SizedBox(height: 12),
                    _buildReceiverPhoneField(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Delivery Address"),
                    _buildCityDropdowns(),
                    const SizedBox(height: 12),
                    _buildStreetDropdowns(),
                    const SizedBox(height: 12),
                    _buildHouseNoField(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Optional: "),
                    _buildNoteField(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Payment"),
                    _buildPaymnetDropdown(),
                    const SizedBox(height: 24),
                    _buildPlaceOrderButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title),
    );
  }

  Widget _buildReceiverNameField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Receiver Name',
        prefixIcon: Icon(Icons.person, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  Widget _buildReceiverPhoneField() {
    return TextFormField(
      controller: _phoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your phone number';
        }
        if (value.length != 11) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Receiver Phone',
        prefixIcon: Icon(Icons.person, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  Widget _buildCityDropdowns() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) => _buildSearchableField(
        label: "City",
        value: state.selectedCity ?? "Select City",
        onTap: () => _showSearchModal(context, "City"),
        icon: Icons.location_city,
      ),
    );
  }

  Widget _buildStreetDropdowns() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) => _buildSearchableField(
        label: "Street",
        value: state.selectedStreet ?? "Select Street",
        onTap: state.selectedCity == null
            ? null
            : () => _showSearchModal(context, "Street"),
        icon: Icons.map_outlined,
      ),
    );
  }

  Widget _buildSearchableField({
    required String label,
    required String value,
    VoidCallback? onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(value),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _buildHouseNoField() {
    return TextFormField(
      controller: _houseNoController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter house number';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'House/Apartment No.',
        prefixIcon: Icon(Icons.home_outlined, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      keyboardType: TextInputType.text,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Additional note: ',
        prefixIcon: Icon(Icons.note_add, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  Widget _buildPaymnetDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: 'Cash on Delivery',
      items: [
        'Cash on Delivery',
        'Credit Card',
        'PayPal',
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) => setState(() {
        _selectedPayment = val!;
      }),
      decoration: const InputDecoration(labelText: 'Payment Method'),
    );
  }

  Widget _buildPlaceOrderButton() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, addressState) {
        return BlocConsumer<OrderBloc, OrderState>(
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
                  : () => _onPlaceOrder(context, addressState),
              child: state.status == OrderStatus.loading
                  ? const CircularProgressIndicator()
                  : Text('Pay  \$${widget.totalAmount}'),
            );
          },
        );
      },
    );
  }

  void _onPlaceOrder(BuildContext context, AddressState addressState) {
    if (!_formKey.currentState!.validate() ||
        addressState.selectedStreet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all address fields')),
      );
      return;
    }
    final fullAddress =
        "${_houseNoController.text}, ${addressState.selectedStreet}, ${addressState.selectedCity}";

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
        address: fullAddress,
        receiverName: _nameController.text.trim(),
        receiverPhone: _phoneController.text.trim(),
        paymentMethod: _selectedPayment,
        description: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      ),
    );
  }

  void _showSearchModal(BuildContext context, String type) {
    final cubit = BlocProvider.of<AddressCubit>(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search $type...",
                  prefix: const Icon(Icons.search),
                ),
                onChanged: (v) => type == "City"
                    ? cubit.filterCities(v)
                    : cubit.filterStreets(v),
              ),
              Expanded(
                child: BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    final list = type == "City"
                        ? state.filteredCities
                        : state.filteredStreets;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(list[index]),
                        onTap: () {
                          type == "City"
                              ? cubit.selectCity(list[index])
                              : cubit.selectedStreet(list[index]);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
