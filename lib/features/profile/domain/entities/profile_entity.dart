class ProfileEntity {
  final String id;
  final String email;
  final String? username;
  final String? avatarUrl;

  ProfileEntity({
    required this.id,
    required this.email,
    this.username,
    this.avatarUrl,
  });

ProfileEntity copyWith({String? username, String? email}) {
  return ProfileEntity(
    id: id,
    username: username ?? this.username,
    email: email ?? this.email,
  );
}
}