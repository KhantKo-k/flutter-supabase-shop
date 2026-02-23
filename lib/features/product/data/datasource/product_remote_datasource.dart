
import 'package:shop_project/features/product/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts({String? category});
  Future<List<String>> getCategories();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final SupabaseClient client;

  ProductRemoteDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts({
    String? category,
  }) async {

      var query = client.from('products').select();

      if (category != null && category.isNotEmpty) {
        query = query.ilike('category', category);
      }

      final response = await query.order('created_at');
      if (response.isEmpty) {
        return []; // Return empty list instead of failure
      }

      return 
        response.map((json) => ProductModel.fromJson(json)).toList();
   
  }

  @override
  Future<List<String>> getCategories() async {
    
      final response = await client.from('products').select('category');

      final categories = response
          .map<String>(
            (json) => (json['category'] as String).trim().toLowerCase(),
          )
          .where((c) => c.isNotEmpty)
          .toSet() // removes duplicates
          .map(
            (c) => c[0].toUpperCase() + c.substring(1),
          )
          .toList();

      return categories;
   
  }
}
