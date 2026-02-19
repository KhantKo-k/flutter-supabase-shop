import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';
import 'package:shop_project/features/auth/domain/password/usecases/accout_delete_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/login_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/logout_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/sign_up_use_case.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteUseCase;
  final AuthLocalStorage authLocalStorage;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
    required this.authLocalStorage,
    required this.deleteUseCase,
    EmailIdentity? initialIdentity,
  }) : super(AuthInitial()) {
    on<AuthPrefillRequested>(_onPrefill);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AccountDeletionRequest>(_onDeleteRequest);
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
    // String? currentEmail = state.email;
    // String? currentUsername = state.username;
    // String? currentAvatar = state.avatarUrl;

    // if (currentEmail == null || currentEmail.isEmpty) {
    //   final storedIdentity = authLocalStorage.getIdentity();
    //   if (storedIdentity != null && storedIdentity.email.isNotEmpty) {
    //     currentEmail = storedIdentity.email;
    //     currentUsername = storedIdentity.username;
    //     currentAvatar = storedIdentity.avatarUrl;
    //   }
    // }

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
    await authLocalStorage.clearIdentity();
    logoutUseCase();
    emit(const Unauthenticated());
  }

  Future<void> _onDeleteRequest(
    AccountDeletionRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final result = await deleteUseCase();

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(const Unauthenticated()),
      );
    } catch (e) {
      emit(AuthError('Failed to delete account: ${e.toString()}'));
    }
  }
}
