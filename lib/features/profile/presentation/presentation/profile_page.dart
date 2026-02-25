import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/common_widgets/common_app_bar.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/presentation/bloc/order_bloc.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isEditing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadMyOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Profile'),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset('assets/images/bubble7.png'),
              ),
              _buildProfileHeader(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Order Histroy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          _buildOrderHistory(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ProfileError) {
          return Center(child: Text(state.message));
        }

        if (state is ProfileUpdating) {
          return const CircularProgressIndicator();
        }

        if (state is ProflileLoaded) {
          return Column(
            children: [_buildProfileDetail(state.profile, context)],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildProfileDetail(ProfileEntity profile, BuildContext context) {
    if (!isEditing) {
      _usernameController.text = profile.username ?? '';
      _phoneController.text = profile.phone ?? '';
    }
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                _buildAvatar(),

                const SizedBox(height: 12),

                _buildUsernameField(),

                const SizedBox(height: 12),

                _buildPhoneField(),

                const SizedBox(height: 12),
                isEditing
                    ? _buildCancelSaveButoons(profile)
                    : _buildEditButton(),
              ],
            ),
          ),

          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              onPressed: () => _showProfileDeleteConfirmation(context),
              icon: Icon(Icons.delete_outline, color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40));
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      enabled: isEditing,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextField(
      controller: _phoneController,
      enabled: isEditing,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone_enabled),
      ),
    );
  }

  Widget _buildCancelSaveButoons(ProfileEntity profile) {
    return Row(
      children: [
        _buildCancelButton(profile),

        const SizedBox(width: 12),

        _buildSaveButton(profile),
      ],
    );
  }

  Widget _buildCancelButton(ProfileEntity profile) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            isEditing = false;
            _usernameController.text = profile.username ?? '';
            _phoneController.text = profile.phone ?? '';
          });
        },
        child: const Text('Cancel'),
      ),
    );
  }

  Widget _buildSaveButton(ProfileEntity profile) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          final updatedProfile = profile.copyWith(
            username: _usernameController.text,
            phone: _phoneController.text,
          );
          context.read<ProfileBloc>().add(UpdateProfle(updatedProfile));
          setState(() {
            isEditing = false;
          });
        },
        child: const Text('Save'),
        //label: const Text('Update Profile'),
      ),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          isEditing = true;
        });
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit Profile'),
    );
  }

  Widget _buildOrderHistory() {
    return Expanded(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          switch (state.status) {
            case OrderStatus.initial:
            case OrderStatus.loading:
              return _buildLoadingIndicator();
            case OrderStatus.loaded:
              return _buildOrderList(state.orders);
            case OrderStatus.failure:
              return _buildErrorState(state.failure!.message);

            case OrderStatus.success:
              return _buildOrderList(state.orders);
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String message) {
    return Center(child: Text(message));
  }

  Widget _buildOrderList(List<OrderEntity> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          leading: const Icon(Icons.receipt_long),
          title: Text("Order #${order.orderDisplayId}"),
          subtitle: Text("Total : \$${order.orderDisplayId}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.read<OrderBloc>().add(LoadOrderItems(order.id));
            _showOrderDetailSheet(context, order);
          },
        );
      },
    );
  }
}

void _showOrderDetailSheet(BuildContext context, OrderEntity order) {
  Widget buildReceiptHeader(OrderEntity order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order Pay Slip',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text("Order ID: #${order.orderDisplayId}"),
        const SizedBox(height: 16),
        const Text(
          "DELIVERY ADDRESS",
          style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold),
        ),
        Text(order.address),
      ],
    );
  }

  Widget buildPriceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemList(List<OrderItemEntity> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                "${item.quantity}x",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(item.productName)),
              Text("\$${(item.price * item.quantity).toStringAsFixed(2)}"),
            ],
          ),
        );
      },
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    //backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                switch (state.status) {
                  case OrderStatus.initial:
                  case OrderStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case OrderStatus.loaded:
                  case OrderStatus.success:
                    final items = state.orderItems;
                    if (items.isEmpty) {
                      return const Center(
                        child: Text('No itmes found for this order'),
                      );
                    }
                    final subTotal = items.fold(
                      0.0,
                      (sum, item) => sum + (item.price * item.quantity),
                    );
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          SizedBox(width: 40, height: 4),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                buildReceiptHeader(order),
                                const SizedBox(height: 24),

                                const Text(
                                  'ITEMS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const Divider(),
                                buildItemList(items),
                                const SizedBox(height: 16),
                                const DashedDivider(),
                                const SizedBox(height: 16),
                                buildPriceRow(
                                  "Subtotal",
                                  "\$${subTotal.toStringAsFixed(2)}",
                                ),
                                buildPriceRow("Delivery Fee", "Free"),
                                const Divider(height: 32),
                                buildPriceRow(
                                  "Total Amount",
                                  "\$${subTotal.toStringAsFixed(2)}",
                                  isBold: true,
                                ),

                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                    onPressed: () => _showDeleteConfirmation(
                                      context,
                                      order.id,
                                    ),
                                    label: const Text('Delete'),
                                    icon: const Icon(Icons.delete_outline),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.error,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  case OrderStatus.failure:
                    return Center(child: Text(state.failure!.message));
                }
              },
            ),
          );
        },
      );
    },
  );
}

void _showDeleteConfirmation(BuildContext context, String orderId) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text(
          'Are you sure you want to delete this order? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<OrderBloc>().add(DeleteOrder(orderId));
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      );
    },
  );
}

void _showProfileDeleteConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text(
          'Are you sure you want to delete this profile? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AccountDeletionRequest());
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      );
    },
  );
}

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}
