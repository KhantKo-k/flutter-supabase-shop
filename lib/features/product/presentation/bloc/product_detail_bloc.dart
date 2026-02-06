
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/presentation/bloc/product_detail_event.dart';
import 'package:shop_project/features/product/presentation/bloc/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required Product product})
    : super(ProductDetailState(product: product, quantity: 1,)){
      on<QuantityIncreased> (_onIncrease);
      on<QuantityDecreased> (_onDecrease);
    }

    void _onIncrease( 
      QuantityIncreased event, Emitter<ProductDetailState> emit
    ) {
      emit(state.copyWith(quantity: state.quantity + 1));
    }

    void _onDecrease( 
      QuantityDecreased event, Emitter<ProductDetailState> emit
    ) {
      if(state.quantity > 1){
        emit(state.copyWith(quantity: state.quantity - 1));
      }
      
    }
}