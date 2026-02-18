
import 'package:equatable/equatable.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

enum ProductListStatus{
  initial,
  loading,
  loaded,
  failure,
}

class ProductListState extends Equatable{
  final ProductListStatus status;
  final List<Product> products;

  final Failure? failure;

  const ProductListState({
    this.status = ProductListStatus.initial,
    this.products = const [],
    this.failure,
  });

  @override
  List<Object?> get props =>
    [status, products, failure];

  ProductListState copyWith({
    ProductListStatus? status,
    List<Product>? products,
    bool? hasReachMax,
    Failure? failure,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
      failure: failure ?? this.failure,
    );
  }
}