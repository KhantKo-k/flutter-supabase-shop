import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> login(
    String email, 
    String password
    );
  
  Future<void> logout();

  Future<Either<Failure,UserEntity>> signUp(
     String username,
     String email,
     String password,
  );
}