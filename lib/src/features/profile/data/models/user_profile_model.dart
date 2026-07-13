import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.imageUrl,
    super.bio,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final firstName = (json['firstName'] ?? json['first_name'] ?? '')
        .toString();
    final lastName = (json['lastName'] ?? json['last_name'] ?? '').toString();
    final fullName = (json['name'] ?? '$firstName $lastName').toString().trim();

    return UserProfileModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: fullName,
      email: (json['email'] ?? '').toString(),
      imageUrl:
          (json['profileImageUrl'] ??
                  json['profile_image_url'] ??
                  json['imageUrl'] ??
                  json['image_url'] ??
                  '')
              .toString(),
      bio: json['bio']?.toString(),
    );
  }
}
