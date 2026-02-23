
import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:shop_project/features/profile/data/model/profile_model.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';
import 'package:shop_project/features/profile/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ProfileEntity>> getMyProfile() async {
    try{
      final profile = await datasource.getProfile();
      return Right(profile);
    } on AuthException {
      return Left(AuthFailure(FailureMessages.invalidCredentials));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure(e.message));
    } catch(_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile( 
    ProfileEntity profile,
  ) async {
    try{
      final data = await datasource.updateProfile(
        ProfileModel(
          id: profile.id, 
          email: profile.email,
          phone: profile.phone,
          username: profile.username,
          avatarUrl: profile.avatarUrl,
        )
      );
      return Right(data);
    } catch (_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }
}