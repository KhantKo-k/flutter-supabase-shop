import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/password/datasource/auth_remote_data_source.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure,UserEntity>> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<Either<Failure,UserEntity>> signUp(String username,String email, String password) {
    return remoteDataSource.signUp(username, email, password);
  }
  
  @override
  Future<void> logout() async {
    return;
  }
}
