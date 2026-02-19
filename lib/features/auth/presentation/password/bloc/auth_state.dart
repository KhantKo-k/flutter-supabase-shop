import 'package:equatable/equatable.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  final String? email;
  final String? username;
  final String? avatarUrl;

  const AuthState({this.email, this.username, this.avatarUrl});

  @override
  List<Object?> get props => [email, username, avatarUrl];
}

class AuthInitial extends AuthState {
  const AuthInitial({super.email, super.username, super.avatarUrl});

  // factory AuthInitial.fromIdentity(EmailIdentity? identity){
  //   if(identity == null){
  //     return const AuthInitial();
  //   }
  //   return AuthInitial(
  //     email: identity.email,
  //     username: identity.username,
  //     avatarUrl: identity.avatarUrl,
  //   );
  // }
}

class LoginLoading extends AuthState {
  const LoginLoading({super.email, super.username, super.avatarUrl});
}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message, {super.email, super.username, super.avatarUrl});

  @override
  List<Object> get props => [message];
}

class SignUpSuccess extends AuthState {}

class AccountDeletion extends AuthState{}