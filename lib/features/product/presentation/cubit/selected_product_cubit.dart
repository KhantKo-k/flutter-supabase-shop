
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';

class SelectedProductCubit extends Cubit<Product?>{
  SelectedProductCubit() : super(null);

  void setSelectedProduct(Product product){
    emit(product);
  }

  void clearSelectedProduct(){
    emit(null);
  }

}