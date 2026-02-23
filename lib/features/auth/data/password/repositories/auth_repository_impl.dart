import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/password/datasource/auth_remote_data_source.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalStorage local;

  AuthRepositoryImpl(this.remoteDataSource, this.local);

  @override
  Future<Either<Failure,UserEntity>> login(String email, String password) async {
    //return remoteDataSource.login(email, password);
    try{
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } on SocketException {
      return left(const NetworkFailure(FailureMessages.networkError));
    } catch (e) {
      return left(const UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure,UserEntity>> signUp(String username,String email, String password, String phone) async {
    //return remoteDataSource.signUp(username, email, password, phone);

    try{
      final user = await remoteDataSource.signUp(username, email, password, phone);
      return Right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } on SocketException {
      return left(const NetworkFailure(FailureMessages.networkError));
    } catch (e) {
      return left(const UnknownFailure(FailureMessages.unexpectedError));
    }
  }
  
  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try{
      await remoteDataSource.accountDeletion();

      await local.clearIdentity();

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
