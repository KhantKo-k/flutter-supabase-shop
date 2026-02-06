import 'package:equatable/equatable.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent{

  final String password;

  const LoginRequested({

    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

class SignUpRequested extends AuthEvent{
  final String username;
  final String email;
  final String password;
  const SignUpRequested({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent{
  const LogoutRequested();
}
class AppStarted extends AuthEvent {}

class AuthPrefillRequested extends AuthEvent {
  final EmailIdentity identity;

  const AuthPrefillRequested(this.identity);

  @override
  List<Object?> get props => [identity];
}