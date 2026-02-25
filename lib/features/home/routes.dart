import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/features/cart/routes.dart';
import 'package:shop_project/features/home/presentation/home_page.dart';
import 'package:shop_project/features/home/presentation/splash_screen.dart';
import 'package:shop_project/features/product/routes.dart';
import 'package:shop_project/features/profile/routes.dart';

final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _cartNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

class HomeRoutes {
  static const splash = '/';
  static const home = ProductRoutes.products;
  static const profile = ProfileRoutes.profile;
  static const cart = CartRoutes.cart;

  static final routes = [
    GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            ...ProductRoutes.shellRoutes,
            
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _cartNavigatorKey,
          routes: [
            ...CartRoutes.shellroutes,
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            ...ProfileRoutes.shellRoutes,

          ],
        ),
      ],
    ),
  ];
}
