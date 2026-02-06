abstract class ProductDetailEvent {}

class QuantityIncreased extends ProductDetailEvent {}

class QuantityDecreased extends ProductDetailEvent {}

class AddToCartPressed extends ProductDetailEvent {}