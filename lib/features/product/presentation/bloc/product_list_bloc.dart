import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:shop_project/features/product/domain/usecases/get_product_use_case.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_event.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductUseCase getProducts;
  final GetCategoriesUsecase getCategories;

  ProductListBloc({required this.getProducts,required this.getCategories}) : super(const ProductListState()) {
    on<ProductListFetched>(_onFetched);
    on<FetchCategories> (_onfetchCategories);
    on<FilterProductsByCategory> (_onFilterByCategory);
  }

  Future<void> _onFetched(
    ProductListFetched event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: ProductListStatus.loading, failure: null));

    final products = await getProducts();
    products.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductListStatus.failure,
          failure: DataNotFoundFailure('Failed to load products'),
        ),
      ),
      (products) => emit(
        state.copyWith(status: ProductListStatus.loaded, products: products),
      ),
    );
  }

  Future<void> _onfetchCategories( 
    FetchCategories event,
    Emitter<ProductListState> emit,
  ) async {
    final result = await getCategories();

    result.fold(
      (failure) => emit( 
        state.copyWith(
          status: ProductListStatus.failure,
          failure: failure,
        ),
      ),
      (categories) => emit( 
        state.copyWith(
          categories: ['All', ...categories],
        ),
      ),
    );
  }

  Future<void> _onFilterByCategory( 
    FilterProductsByCategory event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(
      status: ProductListStatus.loading,
      selectedCategory: event.category,
    ));

    final result = await getProducts(category: event.category);
    result.fold(
      (failure) => emit( 
        state.copyWith(
          status: ProductListStatus.failure,
          failure: failure,
        )
      ), 
      (products) => emit( 
        state.copyWith(
          status: ProductListStatus.loaded,
          products: products,
        ),
      ),
    );
  }
}
