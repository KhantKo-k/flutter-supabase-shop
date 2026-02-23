import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:shop_project/features/product/domain/usecases/get_product_use_case.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_event.dart';
import 'package:shop_project/features/product/presentation/cubit/selected_product_cubit.dart';
import 'package:shop_project/features/product/presentation/page/product_detail_page.dart';
import 'package:shop_project/features/product/presentation/page/product_list_page.dart';

class ProductRoutes {
  static const String products = '/products';
  static const String productDetail = '/products/:productId';

  static final shellRoutes = [
    GoRoute(
      path: products,
      builder: (context, state) => BlocProvider(
        create: (_) =>
            ProductListBloc(
                getProducts: serviceLocator.get<GetProductUseCase>(),
                getCategories: serviceLocator.get<GetCategoriesUsecase>(),
              )
              ..add(ProductListFetched())
              ..add(FetchCategories()),
        child: const ProductListPage(),
      ),
    ),
  ];

  static final routes = [
    GoRoute(
      path: productDetail,
      builder: (context, state) {
        final product = state.extra as Product?;

        if (product == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }

        return ProductDetailPage(product: product);

        // return BlocProvider(
        //   key: ValueKey(product.id),
        //   create: (_) => ProductDetailBloc(product: product),
        //   child: const ProductDetailPage(),
        // );
      },
    ),

    // GoRoute(
    //   path: productDetail,
    //   builder: (context, state) {
    //     return BlocProvider(
    //       key: ValueKey(state.pathParameters['productId']),
    //       create: (context) => ProductDetailBloc(
    //         product: context.read<SelectedProductCubit>().state!,
    //         ),
    //       child: const ProductDetailPage(),
    //     );
    //   },
    // )
  ];
}

extension ProductRoutesExtension on AppRouter {
  void navigateToProducts() {
    router.go(ProductRoutes.products);
  }

  void navigateToProductDetail(Product product) {
    serviceLocator.get<SelectedProductCubit>().setSelectedProduct(product);
    router.push(
      ProductRoutes.productDetail.replaceFirst(':productId', product.id),
      extra: product,
    );
  }
}
