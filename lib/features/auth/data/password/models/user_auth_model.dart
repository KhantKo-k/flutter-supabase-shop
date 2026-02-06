
import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/auth/domain/password/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_auth_model.g.dart';

@JsonSerializable()
class UserAuthModel extends UserEntity {
  final String? accessToken;
  final String? refreshToken;

  const UserAuthModel({
    required super.id,
    required super.email,
    super.username,
    super.avatarUrl,
    this.accessToken,
    this.refreshToken,
  });


  factory UserAuthModel.fromSupabase(User user, {
    // required user,
    String? accessToken,
    String? refreshToken,
    Map<String, dynamic>? profile,
  }) {
    return UserAuthModel(
      id: user.id,
      email: user.email ?? '',
      username: profile?['username'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

    factory UserAuthModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthModelToJson(this);
}