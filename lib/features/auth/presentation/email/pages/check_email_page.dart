import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_bloc.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_event.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_state.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/routes.dart';
import 'package:shop_project/features/home/routes.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({super.key});

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final l10n = AppLocalizations.of(context);

    return BlocListener<EmailBloc, EmailState>(
      listener: (context, state) {
        if (state is EmailFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          return;
        }

        if (state is EmailSuccess) {
          context.read<AuthBloc>().add(AuthPrefillRequested(state.profile));
          _navigateToPassword();
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (EmailBloc bloc) => bloc.state is EmailLoading,
          );
          return PopScope(
            canPop: !isLoading,
            child: Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image.asset('assets/images/bubble4.png'),
                      ),
                      Image.asset('assets/images/bubble3.png'),
                      Positioned(
                        right: -10,
                        top: height * 0.4,
                        child: Image.asset('assets/images/bubble5.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset('assets/images/bubble6.png'),
                      ),

                      _buildEmailForm(l10n),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmailForm(AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.login,
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Text('Good to see you back! 🖤', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            _buildInputFields(l10n),

            SizedBox(height: 30),

            _buildLoginButton(l10n),
            SizedBox(height: 10),

            _buildCancelButton(l10n),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields(AppLocalizations l10n) {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (EmailBloc bloc) => bloc.state is EmailLoading,
        );

        return Column(children: [_buildEmailField(isLoading, l10n)]);
      },
    );
  }

  Widget _buildEmailField(bool isLoading, AppLocalizations l10n) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        filled: true,
        // fillColor: AppColors.secondary,
        labelText: l10n.email,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      enabled: !isLoading,
    );
  }

  Widget _buildLoginButton(AppLocalizations l10n) {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (EmailBloc bloc) => bloc.state is EmailLoading,
        );
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            // Change to your preferred color
            foregroundColor: Colors.white,
            minimumSize: const Size(
              double.infinity,
              55,
            ), // Makes it wide like the fields
          ),
          onPressed: isLoading ? null : _login,
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(l10n.login, style: TextStyle(fontSize: 18)),
        );
      },
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<EmailBloc>().add(EmailSubmitted(email: _emailController.text));
  }

  Widget _buildCancelButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Center(
        child: TextButton(
          onPressed: () {
            context.go(HomeRoutes.splash);
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            l10n.cancel,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _navigateToPassword() {
    debugPrint('Pressing login');
    serviceLocator.get<AppRouter>().navigateToPassword();
  }
}
