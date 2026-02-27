import 'package:dartz/dartz.dart';
import 'package:shop_project/core/base/repository.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

abstract class EmailRepository extends Repository{
  Future<Either<Failure, EmailIdentity>> checkEmail( 
    String email,
  );
}