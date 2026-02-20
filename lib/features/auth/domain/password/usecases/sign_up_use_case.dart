import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure,UserEntity>> call (String username, String email, String password,String phone){
    return repository.signUp(username,email,password,phone);
  }
}