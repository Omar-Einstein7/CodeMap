import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String? bio;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.bio,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? bio,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [id, name, email, imageUrl, bio];
}
