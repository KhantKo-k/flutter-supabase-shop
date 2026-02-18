import 'package:shop_project/features/order/data/model/order_item_model.dart';
import 'package:shop_project/features/order/data/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDatasource {
  Future<String> createOrder(double totalAmount);

  Future<void> insertOrderItems(String orderId, List<OrderItemModel> itmes);

  Future<List<OrderModel>> getOrders();

  Future<List<OrderItemModel>> getOrderItems(String orderId);

  Future<void> deleteOrder(String orderId);
}

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource{
  final SupabaseClient client;

  OrderRemoteDatasourceImpl(this.client);

  @override
  Future<String> createOrder(double totalAmount) async {
    final userId = client.auth.currentUser?.id;

    if(userId == null){
      throw AuthException('User not authenticated');
    }
    final response = await client
    .from('orders')
    .insert({
      'user_id': userId,
      'total_amount': totalAmount,
    })
    .select()
    .single();

    return response['id'];
  }

  @override
  Future<void> insertOrderItems( 
    String orderId,
    List<OrderItemModel> items
  ) async {
    final data = items.map((e) => e.toInsertJson(orderId)).toList();
    await client.from('order_items').insert(data);
  }
  
  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await client
      .from('orders')
      .select()
      .order('created_at', ascending: false);

    return response.map((e)=> OrderModel.fromJson(e)).toList();
  }

  @override
  Future<List<OrderItemModel>> getOrderItems(String orderId) async {
    final response = await client
      .from('order_items')
      .select()
      .eq('order_id', orderId);

    return response.map((e) => OrderItemModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    await client
      .from('orders')
      .delete()
      .eq('id', orderId);
  }
}
