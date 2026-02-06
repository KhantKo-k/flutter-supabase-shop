import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure,UserEntity>> call(
    String email, String password
  ) async {
    return await repository.login(email,password);
  }
}