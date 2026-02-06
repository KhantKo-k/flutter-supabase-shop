import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/email/datasource/email_remote_datasource.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';
import 'package:shop_project/features/auth/domain/email/repository/email_repository.dart';

class EmailRepositoryImpl implements EmailRepository {
  final EmailRemoteDatasource remoteDatasource;

  EmailRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, EmailIdentity>> checkEmail(String email) {
    return remoteDatasource.checkEmail(email);
  }
}
