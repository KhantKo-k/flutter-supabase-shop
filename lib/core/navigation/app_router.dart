import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/navigation/router_refresh_listenable.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';
import 'package:shop_project/features/auth/routes.dart';
import 'package:shop_project/features/home/routes.dart';
import 'package:shop_project/features/product/routes.dart';

class AppNavigatiorKey {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}

class AppRouter {
  final GoRouter router;
  AppRouter(AuthBloc authBloc)
    : router = GoRouter(
        navigatorKey: AppNavigatiorKey.navigatorKey,
        routes: [...AuthRoutes.routes, ...HomeRoutes.routes, ...ProductRoutes.routes],
        redirect: (context, state) {
          final authState = authBloc.state;
          final isAuthenticated = authState is Authenticated;

          final authPaths = [
            HomeRoutes.splash,
            AuthRoutes.email,
            AuthRoutes.signup,
            AuthRoutes.password, // Add this!
          ];
          debugPrint("Current path: ${state.fullPath}");
          
          debugPrint("Current state: $authState");

          if(isAuthenticated && authPaths.contains(state.fullPath)){
            return HomeRoutes.home;
          }

          if(!isAuthenticated && !authPaths.contains(state.fullPath)){
            return HomeRoutes.splash;
          }

          return null;

          // if (state.topRoute?.path == AuthRoutes.password && !isAuthenticated) {
          //   return AuthRoutes.password;
          // }

          // if (!isAuthenticated &&
          //     (state.fullPath != HomeRoutes.splash &&
          //         state.fullPath != AuthRoutes.email &&
          //         state.fullPath != AuthRoutes.signup)) {
          //   debugPrint("Not authenticated, redirecting to landing");
          //   return HomeRoutes.splash;
          // }

          // if (state.topRoute?.path == AuthRoutes.password && isAuthenticated) {
          //   debugPrint("Login success, redirecting to home");
          //   return HomeRoutes.home;
          // }
          // return null;
        },
        refreshListenable: RouterRefreshListenable(authBloc.stream),
      );
}
