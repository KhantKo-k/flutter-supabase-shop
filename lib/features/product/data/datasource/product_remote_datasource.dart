import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRemoteDatasource {
  Future<Either<Failure, List<ProductModel>>> getProducts({String? category});
  Future<Either<Failure, List<String>>> getCategories();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final SupabaseClient client;

  ProductRemoteDatasourceImpl(this.client);

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    String? category,
  }) async {
    try {
      // final response = await client
      //   .from('products')
      //   .select()
      //   .order('created_at');

      var query = client.from('products').select();

      if (category != null && category.isNotEmpty) {
        query = query.ilike('category', category);
      }

      final response = await query.order('created_at');
      if (response.isEmpty) {
        return right([]); // Return empty list instead of failure
      }

      return right(
        response.map((json) => ProductModel.fromJson(json)).toList(),
      );
    } on SocketException catch (_) {
      return left(
        const NetworkFailure('Please check your internet connection'),
      );
    } on PostgrestException catch (e) {
      return left(SupabaseFailure('Database error: ${e.message}'));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      return left(const UnknownFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
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

      return right(categories);
    } on SocketException catch (_) {
      return left(
        const NetworkFailure('Please check your internet connection'),
      );
    } on PostgrestException catch (e) {
      return left(SupabaseFailure('Database error: ${e.message}'));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
      return left(const UnknownFailure('Something went wrong'));
    }
  }
}
