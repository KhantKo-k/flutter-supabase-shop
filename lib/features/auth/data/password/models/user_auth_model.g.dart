// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthModel _$UserAuthModelFromJson(Map<String, dynamic> json) =>
    UserAuthModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$UserAuthModelToJson(UserAuthModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
