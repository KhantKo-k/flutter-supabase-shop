import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/core/common_widgets/language_selector.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';
import 'package:shop_project/features/auth/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context, l10n));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: () => context.read<ThemeCubit>().toogleTheme(), 
        icon: const Icon(Icons.brightness_6)
        ),
        const LanguageSelector()
        ],
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 180),
          _buildLogo(),

          SizedBox(height: 12),
          _buildAppName(l10n),

          _buildWelcomeText(l10n),

          SizedBox(height: 90),

          _buildSignUpButton(context, l10n),

          _buildLoginButton(context, l10n),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(120),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2.5,
            offset: const Offset(1.7, 0.8),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset('assets/svgs/logo.svg', height: 60, width: 60),
      ),
    );
  }

  Widget _buildAppName(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        l10n.appName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }

  Widget _buildWelcomeText(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 12.0),
      child: Center(
        child: Text(
          'Welcome to our shopping app. We make your shopping exerpiences ease and convinent.',
          textAlign: TextAlign.center,
          style: TextStyle(height: 2.5, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: _navigateToSignUp,
        child: Text(
          l10n.letsStart,
          //'Let\'s get started!',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: GestureDetector(
        onTap: _navigateToLogin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              l10n.alreadyAcc,
              //'Already have an account?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 12),
            Icon(Icons.next_plan, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  void _navigateToSignUp(){
    serviceLocator.get<AppRouter>().navigateToSignUp();
  }

  void _navigateToLogin(){
    debugPrint('Pressing login');
    serviceLocator.get<AppRouter>().navigateToEmail();
  }
}
