import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      firstName: (json['firstName'] ?? json['first_name'] ?? '').toString(),
      lastName: (json['lastName'] ?? json['last_name'] ?? '').toString(),
      profileImageUrl: (json['profileImageUrl'] ?? json['profile_image_url'])
          ?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_image_url': profileImageUrl,
    };
  }
}

class AuthResponseModel {
  final UserModel user;
  final String token;

  const AuthResponseModel({required this.user, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final payload = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    final userJson = payload['user'] ?? payload;
    if (userJson is! Map) {
      throw const FormatException(
        'Auth response does not contain a user object',
      );
    }

    final token =
        (payload['token'] ??
                payload['accessToken'] ??
                payload['access_token'] ??
                '')
            .toString();
    if (token.isEmpty) {
      throw const FormatException('Auth response does not contain a token');
    }

    return AuthResponseModel(
      user: UserModel.fromJson(Map<String, dynamic>.from(userJson)),
      token: token,
    );
  }
}
