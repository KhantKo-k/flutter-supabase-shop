import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState{}

class ProfileLoading extends ProfileState{}

class ProflileLoaded extends ProfileState{ 
  final ProfileEntity profile;
  ProflileLoaded(this.profile);
}

class ProfileUpdating extends ProfileState{}

class ProfileUpdated extends ProfileState{}

class ProfileError extends ProfileState{
  final String message;
  ProfileError(this.message);
}