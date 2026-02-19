import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getMyProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile);
}