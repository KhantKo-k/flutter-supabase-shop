import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shop_project/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_project/features/profile/presentation/presentation/profile_page.dart';

class ProfileRoutes {
  static const String profile = '/profile';

  static final shellRoutes = [
    GoRoute(
      path: profile,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ProfileBloc(
            getMyProfile: serviceLocator(),
            updateProfile: serviceLocator(),
            authLocalStorage: serviceLocator(),
          )..add(LoadProfile()),
          child: ProfilePage(),
        );
      },
    ),
  ];
}
