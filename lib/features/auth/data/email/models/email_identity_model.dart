import 'package:json_annotation/json_annotation.dart';
import 'package:shop_project/features/auth/domain/email/entity/email_identity.dart';

part 'email_identity_model.g.dart';

@JsonSerializable()
class EmailIdentityModel extends EmailIdentity{
  const EmailIdentityModel({
    required super.email,
    required super.username,
    super.avatarUrl,
  });

  factory EmailIdentityModel.fromJson(Map<String, dynamic> json) =>
      _$EmailIdentityModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailIdentityModelToJson(this);
}