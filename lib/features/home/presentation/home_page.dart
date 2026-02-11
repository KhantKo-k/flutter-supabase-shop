import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/common_widgets/language_selector.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: navigationShell,
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => context.read<ThemeCubit>().toogleTheme(),
          icon: const Icon(Icons.brightness_6),
        ),
        const LanguageSelector(),
        IconButton(onPressed: () {
          print('pressing log out');
          context.read<AuthBloc>().add(LogoutRequested()); },
        icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    return BottomNavigationBar(
      selectedItemColor: context.primaryColor, // Use your blue
      unselectedItemColor: isDark ? Colors.white60 : Colors.grey.shade600,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Homes'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        navigationShell.goBranch(index);
      },
    );
  }
}

class ChildPage extends StatelessWidget {
  final String pageName;

  const ChildPage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(pageName));
  }
}
