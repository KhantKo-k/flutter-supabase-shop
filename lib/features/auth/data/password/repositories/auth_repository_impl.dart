import 'package:dartz/dartz.dart';
import 'package:shop_project/core/auth/auth_local_storage.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/auth/data/password/datasource/auth_remote_data_source.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:shop_project/features/auth/domain/password/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalStorage local;

  AuthRepositoryImpl(this.remoteDataSource, this.local);

  @override
  Future<Either<Failure,UserEntity>> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<Either<Failure,UserEntity>> signUp(String username,String email, String password, String phone) {
    return remoteDataSource.signUp(username, email, password, phone);
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
