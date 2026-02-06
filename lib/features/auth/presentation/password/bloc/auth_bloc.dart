import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/auth/domain/password/usecases/login_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/logout_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/sign_up_use_case.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    on<AuthPrefillRequested>(_onPrefill);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onPrefill(AuthPrefillRequested event, Emitter<AuthState> emit) {
    emit(
      AuthInitial(
        email: event.identity.email,
        username: event.identity.username,
        avatarUrl: event.identity.avatarUrl,
      ),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentEmail = state.email;
    final currentUsername = state.username;
    final currentAvatar = state.avatarUrl;

    if (currentEmail == null) return;

    emit(
      LoginLoading(
        email: currentEmail,
        username: currentUsername,
        avatarUrl: currentAvatar,
      ),
    );

    final result = await loginUseCase(currentEmail, event.password);

    result.fold(
      (failure) => emit(
        AuthError(
          failure.message,
          email: currentEmail,
          username: currentUsername,
          avatarUrl: currentAvatar,
        ),
      ),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const LoginLoading());

    final result = await signUpUseCase(
      event.username,
      event.email,
      event.password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(SignUpSuccess()),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const Unauthenticated());
  }
}
