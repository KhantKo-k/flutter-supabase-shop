
import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure ,List<Product> >> getProducts();
}