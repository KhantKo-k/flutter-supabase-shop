import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

abstract class EmailRepository {
  Future<Either<Failure, EmailIdentity>> checkEmail( 
    String email,
  );
}