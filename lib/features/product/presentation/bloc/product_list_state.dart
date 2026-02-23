
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

  final List<String> categories;
  final String? selectedCategory;

  final Failure? failure;

  const ProductListState({
    this.status = ProductListStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedCategory,
    this.failure,
  });

  @override
  List<Object?> get props =>
    [status, products, categories, selectedCategory, failure];

  ProductListState copyWith({
    ProductListStatus? status,
    List<Product>? products,
    List<String>? categories,
    String? selectedCategory,
    Failure? failure,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      failure: failure ?? this.failure,
    );
  }
}