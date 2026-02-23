import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/repository/product_repository.dart';

class GetCategoriesUsecase {
  final ProductRepository repository;
  GetCategoriesUsecase(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getCategories();
  }
}