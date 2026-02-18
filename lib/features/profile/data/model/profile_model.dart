

import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ProfileEntity{
  ProfileModel({
    required super.id,
    required super.email,
    super.username,
    super.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
    _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}