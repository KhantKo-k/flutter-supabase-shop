
import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/data/datasource/product_remote_datasource.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts({String? category}){
    return remoteDatasource.getProducts(category: category);
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() {
    return remoteDatasource.getCategories();
  }
}