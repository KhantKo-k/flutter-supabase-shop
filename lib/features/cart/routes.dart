import 'package:go_router/go_router.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/features/cart/domain/entities/cart_item.dart';
import 'package:shop_project/features/cart/presentation/pages/cart_page.dart';
import 'package:shop_project/features/order/presentation/pages/check_out_page.dart';

class CartRoutes {
  static const String cart = '/cart';
  static const String checkout = 'checkout';

  static final shellroutes = [
    GoRoute(
      path: cart,
      builder: (context, state) => const CartPage(),
      routes: [
        GoRoute(
          path: checkout,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return CheckoutPage(
              items: extra['items'], 
              totalAmount: extra['totalAmount']
            );
          },
        )
      ]
    ),
  ];
}
extension CartRoutesExtension on AppRouter{
  void navigateToCart(){
    router.go(CartRoutes.cart);
  }

  void navigateToCheckout({ 
    required List<CartItem> items,
    required double totalAmount,
  }) {
    router.push(
      '${CartRoutes.cart}/${CartRoutes.checkout}',
      extra: {
        'items': items,
        'totalAmount': totalAmount,
      }
    );
  }
}