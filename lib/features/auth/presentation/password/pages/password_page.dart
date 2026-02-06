import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';
import 'package:shop_project/features/home/routes.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  static const int _passwordLength = 8;
  bool _hasError = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          setState(() {
            _hasError = true;
          });
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            _passwordController.clear();
            setState(() {
              _hasError = false;
            });
          });
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (AuthBloc bloc) => bloc.state is LoginLoading,
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
                      _buildLoginForm(l10n),
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

  Widget _buildLoginForm(AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),

            _buildAvatar(),

            _buildWelcomeText(l10n),

            _buildPasswordDots(),

            _buildHiddenPasswordField(),

            Spacer(),

            //SizedBox(height: MediaQuery.sizeOf(context).height * 0.42),

            _buildCancelButton(l10n),

            // SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.background,
      child: Icon(Icons.person, size: 60, color: Colors.black),
    );
  }

  Widget _buildWelcomeText(AppLocalizations l10n) {
    final state = context.watch<AuthBloc>().state;
    final username = state.username ?? "User";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(
            "Hello, $username !",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(l10n.typePassword, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildPasswordDots() {
    final enteredLength = _passwordController.text.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_passwordLength, (index) {
        final isFilled = index < enteredLength;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _hasError
                ? Colors.red
                : isFilled
                ? AppColors.primary
                : Colors.grey.shade400,
          ),
        );
      }),
    );
  }

  Widget _buildHiddenPasswordField() {
    return SizedBox(
      height: 0,
      child: TextField(
        controller: _passwordController,
        autofocus: true,
        keyboardType: TextInputType.number,
        obscureText: true,
        cursorColor: Colors.transparent,
        maxLength: _passwordLength,
        style: const TextStyle(color: Colors.transparent),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _hasError = false;
          });
          if (value.length == _passwordLength) {
            _login();
          }
        },
      ),
    );
  }

  void _login() {
    context.read<AuthBloc>().add(
      LoginRequested(password: _passwordController.text),
    );
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
}
