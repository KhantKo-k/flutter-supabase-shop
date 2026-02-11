import 'package:hive_ce/hive.dart';

part 'email_identity.g.dart';

@HiveType(typeId: 1)
class EmailIdentity {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String? avatarUrl;

  const EmailIdentity({
    required this.email,
    required this.username,
    this.avatarUrl,
  });
}