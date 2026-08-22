/// Pure Domain Entity representing the authenticated user profile.
class UserEntity {
  final String id;
  final String email;

  const UserEntity({
    required this.id,
    required this.email,
  });
}
