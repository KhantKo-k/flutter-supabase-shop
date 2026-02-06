// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_identity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailIdentityModel _$EmailIdentityModelFromJson(Map<String, dynamic> json) =>
    EmailIdentityModel(
      email: json['email'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$EmailIdentityModelToJson(EmailIdentityModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
    };
