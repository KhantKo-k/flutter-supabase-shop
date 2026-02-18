// import 'package:dartz/dartz.dart' hide State;
// import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadMyOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileHeader(),
        //const Divider(thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Order Histroy",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        _buildOrderHistory(),
      ],
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
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 12),
            Text(profile.username ?? 'No name'),
            Text(profile.email),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProfileBloc>().add(UpdateProfle(profile));
              },
              icon: const Icon(Icons.edit),
              label: const Text('Update Profile'),
            ),
          ],
        ),
      ),
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
              break;
          }
          return const Center(child: Text("No orders yet!"));
          // if (state is OrderLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // } else if (state is OrdersLoaded) {
          //   return _buildOrderList(state.orders);
          // } else if (state is OrderFailure) {
          //   return Center(child: Text(state.message));
          // }
          // return const Center(child: Text('No orders yet!'));
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
          title: Text("Order #${order.id}"),
          subtitle: Text("Total : \$${order.totalAmount}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.read<OrderBloc>().add(LoadOrderItems(order.id));
            _showOrderDetailSheet(context, order.id);
          },
        );
      },
    );
  }
}

void _showOrderDetailSheet(BuildContext context, String orderId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) {
          return BlocBuilder<OrderBloc, OrderState>(
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

                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      SizedBox(width: 40, height: 4),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Order Items',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              title: Text(item.productName),
                              subtitle: Text(
                                "Qty: ${item.quantity} x \$${item.price}",
                              ),
                              trailing: Text(
                                '\$${(item.quantity * item.price).toStringAsFixed(2)}',
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _showDeleteConfirmation(context, orderId),
                            label: const Text('Delete this order?'),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ),
                      ),
                    ],
                  );
                case OrderStatus.failure:
                  return Center(child: Text(state.failure!.message));
              }
            },
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
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
