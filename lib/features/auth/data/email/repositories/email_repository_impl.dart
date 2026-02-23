import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/email/datasource/email_remote_datasource.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';
import 'package:shop_project/features/auth/domain/email/repository/email_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailRepositoryImpl implements EmailRepository {
  final EmailRemoteDatasource remoteDatasource;

  EmailRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, EmailIdentity>> checkEmail(String email) async {
    // return remoteDatasource.checkEmail(email);
    try{
      final response = await remoteDatasource.checkEmail(email);
      return Right(response);
    } on PostgrestException catch (_) {
      return Left(const AuthFailure('Email not registered'));
    } on SocketException {
      return left(
        const NetworkFailure('Please check your internet connection'),
      );
    } catch (_) {
      return left(const UnknownFailure('Something went wrong'));
    }
  }
}
