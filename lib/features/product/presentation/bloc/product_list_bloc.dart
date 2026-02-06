import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/product/domain/usecases/get_product_use_case.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_event.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductUseCase getProducts;

  ProductListBloc({required this.getProducts}) : super(const ProductListState()) {
    on<ProductListFetched>(_onFetched);
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
}
