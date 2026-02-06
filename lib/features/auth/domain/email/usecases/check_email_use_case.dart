import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';
import 'package:shop_project/features/auth/domain/email/repository/email_repository.dart';

class CheckEmailUseCase {
  final EmailRepository repository;

  CheckEmailUseCase(this.repository);

  Future<Either<Failure, EmailIdentity>> call( 
    String email,
  ){
    return repository.checkEmail(email);
  }
}