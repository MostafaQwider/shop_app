class UsersEntity {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? role;
  final bool? isVerified;
  final String? verificationCode;
  final DateTime? verificationCodeExpires;
  final String? resetCode;
  final DateTime? resetCodeExpires;
  final DateTime? createdAt;

  UsersEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role,
    this.isVerified,
    this.verificationCode,
    this.verificationCodeExpires,
    this.resetCode,
    this.resetCodeExpires,
    this.createdAt,
  });
}
