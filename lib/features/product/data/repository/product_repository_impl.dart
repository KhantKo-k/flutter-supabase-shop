
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/data/datasource/product_remote_datasource.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/domain/repository/product_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts({String? category}) async {
    //return remoteDatasource.getProducts(category: category);
    try{
      final products = await remoteDatasource.getProducts(category: category);
      return Right(products);
     } on SocketException catch (_) {
      return Left(
        const NetworkFailure('Please check your internet connection'),
      );
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure('Database error: ${e.message}'));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      return Left(const UnknownFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    //return remoteDatasource.getCategories();
    try{
      final categories = await remoteDatasource.getCategories();
      return Right(categories);
     } on SocketException catch (_) {
      return Left(
        const NetworkFailure('Please check your internet connection'),
      );
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure('Database error: ${e.message}'));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
      return Left(const UnknownFailure('Something went wrong'));
    }
  }
}