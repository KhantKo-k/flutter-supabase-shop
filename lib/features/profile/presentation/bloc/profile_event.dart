import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent{}

class UpdateProfle extends ProfileEvent{ 
  final ProfileEntity profile;
  UpdateProfle(this.profile);
}