import 'package:go_router/go_router.dart';
import 'package:shop_project/features/cart/presentation/pages/cart_page.dart';

class CartRoutes {
  static const String cart = '/cart';

  static final shellroutes = [
    GoRoute(
      path: cart,
      builder: (context, state) => const CartPage()
    ),
  ];
}
