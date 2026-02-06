import 'package:go_router/go_router.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/features/auth/presentation/email/pages/check_email_page.dart';
import 'package:shop_project/features/auth/presentation/password/pages/password_page.dart';
import 'package:shop_project/features/auth/presentation/password/pages/sign_up_screen.dart';

class AuthRoutes{
  static const email = '/email';
  static const signup = '/signup';
  static const password = '/password';

  static final routes = [
    GoRoute(
      path: email,
      builder: (context, state) => const CheckEmailPage(),
    ),
    GoRoute(
    path: signup,
    builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: password,
      builder: (context, state) => const PasswordPage()
    )
  ];
}

extension AuthroutesExtension on AppRouter {
  void navigateToSignUp(){
    router.push(AuthRoutes.signup);
  }
  void navigateToEmail(){
    router.push(AuthRoutes.email);
  }
  void navigateToPassword(){
    router.push(AuthRoutes.password);
  }
}