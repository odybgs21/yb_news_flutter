class UserEntity {
  final String id;
  final String email;
  final String? name;
  final bool isFirstLogin;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.isFirstLogin = false,
  });
}
