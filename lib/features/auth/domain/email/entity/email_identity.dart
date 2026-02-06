class EmailIdentity {
  final String email;
  final String username;
  final String? avatarUrl;

  const EmailIdentity({
    required this.email,
    required this.username,
    this.avatarUrl,
  });
}