import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';
import 'package:shop_project/features/auth/domain/password/usecases/login_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/logout_use_case.dart';
import 'package:shop_project/features/auth/domain/password/usecases/sign_up_use_case.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthLocalStorage authLocalStorage;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.logoutUseCase,
    required this.authLocalStorage,
    EmailIdentity? initialIdentity,
  }) : super(AuthInitial()) {
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
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;
//   final SignUpUseCase signUpUseCase;
//   final LogoutUseCase logoutUseCase;
//   final AuthLocalStorage authLocalStorage;

//   AuthBloc({
//     required this.loginUseCase,
//     required this.signUpUseCase,
//     required this.logoutUseCase,
//     required this.authLocalStorage,
//     EmailIdentity? initialIdentity,
//   }) : super(AuthInitial()) {
//     on<AuthPrefillRequested>(_onPrefill);
//     on<LoginRequested>(_onLoginRequested);
//     on<SignUpRequested>(_onSignUpRequested);
//     on<LogoutRequested>(_onLogoutRequested);
//   }

//   void _onPrefill(AuthPrefillRequested event, Emitter<AuthState> emit) {
//     emit(
//       AuthInitial(
//         email: event.identity.email,
//         username: event.identity.username,
//         avatarUrl: event.identity.avatarUrl,
//       ),
//     );
//   }

//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     String? currentEmail = state.email;
//     String? currentUsername = state.username;
//     String? currentAvatar = state.avatarUrl;

//     if (currentEmail == null || currentEmail.isEmpty) {
//       final storedIdentity = authLocalStorage.getIdentity();
//       if (storedIdentity != null && storedIdentity.email.isNotEmpty) {
//         currentEmail = storedIdentity.email;
//         currentUsername = storedIdentity.username;
//         currentAvatar = storedIdentity.avatarUrl;
//       }
//     }

//       final result = await loginUseCase(currentEmail!, event.password);

//       result.fold(
//         (failure) {
//           emit(
//             AuthError(
//               '${failure.message}+${ DateTime.timestamp()}',
//               email: currentEmail,
//               username: currentUsername,
//               avatarUrl: currentAvatar,
//             ),

//           );
//           debugPrint("Error state");
//         },
//         (user) {
//           emit(Authenticated(user: user));
//         },
//       );
//   }

//   Future<void> _onSignUpRequested(
//     SignUpRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(const LoginLoading());

//     try {
//       final result = await signUpUseCase(
//         event.username,
//         event.email,
//         event.password,
//       );

//       if (emit.isDone) return;

//       result.fold(
//         (failure) {
//           if (!emit.isDone) {
//             emit(AuthError(failure.message));
//           }
//         },
//         (_) {
//           if (!emit.isDone) {
//             emit(SignUpSuccess());
//           }
//         },
//       );
//     } catch (e) {
//       if (!emit.isDone) {
//         emit(AuthError('An unexpected error occurred: $e'));
//       }
//     }
//   }

//   Future<void> _onLogoutRequested(
//     LogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       debugPrint('Logging out');
//       await authLocalStorage.clearIdentity();
//       debugPrint('finished clear identity out');

//       logoutUseCase();

//       emit(const Unauthenticated());
//       // if (!emit.isDone) {
//       //   emit(const Unauthenticated());
//       // }
//     } catch (e) {
//       emit(AuthError("Log out error"));
//     }
//   }
// }
