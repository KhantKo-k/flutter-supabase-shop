import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/common_widgets/category_chip.dart';
import 'package:shop_project/core/common_widgets/common_clipper.dart';
import 'package:shop_project/core/common_widgets/language_selector.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/product/domain/entities/product_entity.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_bloc.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_event.dart';
import 'package:shop_project/features/product/presentation/bloc/product_list_state.dart';
import 'package:shop_project/features/product/routes.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductListState state) {
    return CustomScrollView(
      slivers: [
        _buildSilverAppBar(context),
        _buildsilverCategoryFilter(context, state),
        _buildSilverContent(context, state),
      ],
    );
  }

  Widget _buildSilverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160.0,
      floating: false,
      pinned: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => context.read<ThemeCubit>().toogleTheme(),
          icon: const Icon(Icons.brightness_6),
        ),
        const LanguageSelector(),
        IconButton(
          onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
          icon: const Icon(Icons.logout),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          bool isCollapsed =
              top <= (MediaQuery.of(context).padding.top + kToolbarHeight);
          return FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.only(
              left: 20,
              bottom: isCollapsed ? 20 : 75,
            ),
            title: Text(
              "Our Shop",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            background: Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                    ),
                  ),
                ),

                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, Colors.blueAccent.shade700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildsilverCategoryFilter(BuildContext context, ProductListState state){
    if(state.categories.isEmpty){
      return const SliverToBoxAdapter();
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 56,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          itemCount: state.categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = state.categories[index];

            final bool isSelected = (category == 'All' && state.selectedCategory == null) ||
                                    (category == state.selectedCategory);
            return ChoiceChip(
              key: ValueKey(category),
              label: Text(category), 
              selected: isSelected,
              onSelected: state.status == ProductListStatus.loading
              ? null
              : (selected) {
                if(isSelected) return;
                if(category == 'All'){
                  context.read<ProductListBloc>()
                  .add(ProductListFetched());
                } else {
                  context.read<ProductListBloc>()
                  .add(FilterProductsByCategory(category));
                }
              },
            );
          }
        ,),
      ),
    );
  }

  Widget _buildSilverContent(BuildContext context, ProductListState state) {
    switch (state.status) {
      case ProductListStatus.initial:
      case ProductListStatus.loading:
        return _buildLoadingIndicator();
      case ProductListStatus.loaded:
        return _buildProductGrid(context, state);
      case ProductListStatus.failure:
        return _buildErrorState(context, state);
    }
  }

  Widget _buildLoadingIndicator() {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProductGrid(BuildContext context, ProductListState state) {
    final products = state.products;

    if (products.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyList(context));
    }
    return _buildProductList(products);
  }

  Widget _buildEmptyList(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(height: 16),
          _buildEmptyText(),
          const SizedBox(),
          _buildRefreshButton(context),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey);
  }

  Widget _buildEmptyText() {
    return Text('No products available', style: TextStyle(fontSize: 16));
  }

  Widget _buildRefreshButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ProductListBloc>().add(ProductListFetched());
      },
      child: Icon(Icons.refresh),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return SliverPadding(
      padding: const EdgeInsets.all(12.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.66,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildProductCard(products[index]);
        }, childCount: products.length),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      child: Card(
        //color: AppColors.textSecondary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product.imageUrl),
            _buildProductDetail(
              product.name,
              product.price,
              product.category,
              product.description,
            ),
          ],
        ),
      ),
      onTap: () {
        _openProductDetail(product);
      },
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductDetail(
    String name,
    double price,
    String category,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          CategoryChip(category: category),
        ],
      ),
    );
  }

  void _openProductDetail(Product product) {
    serviceLocator.get<AppRouter>().navigateToProductDetail(product);
  }

  Widget _buildErrorState(BuildContext context, ProductListState state) {
    return SliverFillRemaining(child: _buildEmptyList(context));
  }
}
