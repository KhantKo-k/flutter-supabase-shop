import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/di/service_locator.dart';

import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';
import 'package:shop_project/features/auth/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameContrller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameContrller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is SignUpSuccess) {
          // context.read<AuthBloc>().add(LogoutRequested());
          _navigateToLogin();
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return PopScope(
          canPop: !isLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: [
                    _buildUpperSection(),
                    
                    _buildFormSection(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormSection() {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildInputFields(l10n),

          _buildSignUpButton(l10n),

          _buildCancelButton(l10n),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildUpperSection() {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      //color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: -30,
            child: Image.asset('assets/images/bubble1.png'),
          ),
          Positioned(left: 0, child: Image.asset('assets/images/bubble2.png')),
          Positioned(
            top: 140,
            left: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l10n.createAcc,
                //'Create \nAccount',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 30,
            child: Image.asset('assets/images/camera.png'),
          ),

        ],
      ),
    );
  }

  Widget _buildInputFields(AppLocalizations l10n) {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (AuthBloc bloc) => bloc.state is LoginLoading,
        );
        return Column(
          children: [
            _buildUsernameField(l10n, isLoading),
            _buildEmailField(l10n, isLoading),
            _buildPasswordFiled(l10n, isLoading),
            _buildConfirmPasswordField(l10n, isLoading),
          ],
        );
      },
    );
  }

  Widget _buildUsernameField(AppLocalizations l10n, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextFormField(
        controller: _usernameContrller,
        decoration: InputDecoration(
          filled: true,
          labelText: l10n.name,
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField(AppLocalizations l10n, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          filled: true,
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
      ),
    );
  }

  Widget _buildPasswordFiled(AppLocalizations l10n, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          filled: true,
          labelText: l10n.password,
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter password';
          }
          final RegExp passwordRegExp = RegExp(r'^\d{8}$');
          if (!passwordRegExp.hasMatch(value)) {
            return 'Password must be exactly 8 numbers';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(AppLocalizations l10n, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        decoration: InputDecoration(
          filled: true,
          labelText: l10n.password,
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
            icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Confirm your password';
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignUpButton(AppLocalizations l10n) {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (AuthBloc bloc) => bloc.state is LoginLoading,
        );
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // Change to your preferred color
              foregroundColor: Colors.white,
              minimumSize: const Size(
                double.infinity,
                55,
              ), // Makes it wide like the fields
            ),
            onPressed: isLoading ? null : _signUp,
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(l10n.done, style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }

  Widget _buildCancelButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
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

  void _signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      SignUpRequested(
        username: _usernameContrller.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _navigateToLogin() {
    debugPrint('Pressing login');
    serviceLocator.get<AppRouter>().navigateToEmail();
  }
}
