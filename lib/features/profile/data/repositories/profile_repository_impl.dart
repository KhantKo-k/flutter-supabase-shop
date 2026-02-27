import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shop_project/features/profile/data/model/profile_model.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';
import 'package:shop_project/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProfileEntity>> getMyProfile() async {
    return await on(() async => await datasource.getProfile());

  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
    ProfileEntity profile,
  ) async {
    return await on(
      () async => await datasource.updateProfile(
        ProfileModel(
          id: profile.id,
          email: profile.email,
          phone: profile.phone,
          username: profile.username,
          avatarUrl: profile.avatarUrl,
        ),
      ),
    );

  }
}
