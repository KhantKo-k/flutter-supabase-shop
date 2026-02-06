import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<Failure, List<Product> >> call() {
    return repository.getProducts();
  }
}