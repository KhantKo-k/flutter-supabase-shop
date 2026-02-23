abstract class ProductListEvent {}

class ProductListFetched extends ProductListEvent{}

class FetchCategories extends ProductListEvent{}

class FilterProductsByCategory extends ProductListEvent{
  final String category;
  FilterProductsByCategory(this.category);
}
