import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
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
  AppRouter(AuthBloc authBloc, AuthLocalStorage authLocalStorage)
    : router = GoRouter(
        navigatorKey: AppNavigatiorKey.navigatorKey,
        routes: [
          ...AuthRoutes.routes,
          ...HomeRoutes.routes,
          ...ProductRoutes.routes,
        ],
        redirect: (context, state) {
          final authState = authBloc.state;
          final isAuthenticated = authState is Authenticated;

          if (authState is LoginLoading) return null;

          final identity = authLocalStorage.getIdentity();
          final hasIdentity = identity != null;

          final authPaths = [
            HomeRoutes.splash,
            AuthRoutes.email,
            AuthRoutes.signup,
            //AuthRoutes.password,
          ];
          debugPrint("Current path: ${state.fullPath}");

          debugPrint("Current state: $authState");

          if (isAuthenticated && state.topRoute?.path == AuthRoutes.password
              //authPaths.contains(state.fullPath)
              ) {
            return HomeRoutes.home;
          }

          if (!isAuthenticated &&
              hasIdentity &&
              authPaths.contains(state.topRoute?.path)
              //state.topRoute?.path == AuthRoutes.password
              ) {
            return AuthRoutes.password;
          }

          if (!isAuthenticated &&
              !hasIdentity &&
              !authPaths.contains(state.fullPath)) {
            return HomeRoutes.splash;
          }

          return null;
        },
        refreshListenable: RouterRefreshListenable(authBloc.stream),
      );
}
