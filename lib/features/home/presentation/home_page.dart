import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }


  Widget _buildNavigationBar(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
     final l10n = AppLocalizations.of(context);
    return BottomNavigationBar(
      selectedItemColor: context.primaryColor, 
      unselectedItemColor: isDark ? Colors.white60 : Colors.grey.shade600,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: l10n.home),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: l10n.cart),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: l10n.profile),
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
