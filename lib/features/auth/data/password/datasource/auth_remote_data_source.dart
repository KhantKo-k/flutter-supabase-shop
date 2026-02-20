import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/password/models/user_auth_model.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String username, String email, String password, String phone);
  Future<void> accountDeletion();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        return left(const AuthFailure(FailureMessages.unexpectedError));
      }

      return right(UserAuthModel.fromSupabase(user));
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } on SocketException {
      return left(const NetworkFailure(FailureMessages.networkError));
    } catch (e) {
      return left(const UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String username,
    String email,
    String password,
    String phone,
  ) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return left(const AuthFailure(FailureMessages.unexpectedError));
      }

      await client.from('profiles').insert({
        'id': user.id,
        'email': user.email,
        'username': username,
        'avatar_url': null,
        'phone': phone,
        'created_at': DateTime.now().toIso8601String(),
      });

      return right(UserAuthModel.fromSupabase(user));
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } on SocketException {
      return left(const NetworkFailure(FailureMessages.networkError));
    } catch (e) {
      return left(const UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<void> accountDeletion() async {
    final response = await client.functions.invoke('delete-user');

    if(response.status != 200){
      throw Exception('Failed to delete account: ${response.data}');
    }
  }
}
