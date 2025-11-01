import '../../domain/entities/users_entity.dart';

class UsersModel {
  final UsersEntity entity;

  UsersModel({required this.entity});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      entity: UsersEntity(
        id: json['id'],
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        role: json['role'],
        isVerified: json['is_verified'],
        verificationCode: json['verification_code'],
        verificationCodeExpires: json['verification_code_expires'] != null
            ? DateTime.tryParse(json['verification_code_expires'])
            : null,
        resetCode: json['reset_code'],
        resetCodeExpires: json['reset_code_expires'] != null
            ? DateTime.tryParse(json['reset_code_expires'])
            : null,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'])
            : null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (entity.id != null) 'id': entity.id,
      'name': entity.name,
      'email': entity.email,
      'password': entity.password,
      if (entity.role != null) 'role': entity.role,
      if (entity.isVerified != null) 'is_verified': entity.isVerified,
      if (entity.verificationCode != null)
        'verification_code': entity.verificationCode,
      if (entity.verificationCodeExpires != null)
        'verification_code_expires':
        entity.verificationCodeExpires!.toIso8601String(),
      if (entity.resetCode != null) 'reset_code': entity.resetCode,
      if (entity.resetCodeExpires != null)
        'reset_code_expires': entity.resetCodeExpires!.toIso8601String(),
      if (entity.createdAt != null)
        'created_at': entity.createdAt!.toIso8601String(),
    };
  }

  factory UsersModel.fromEntity(UsersEntity entity) {
    return UsersModel(entity: entity);
  }

  UsersEntity toEntity() => entity;
}
