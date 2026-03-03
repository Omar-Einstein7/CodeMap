import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';

class LocalUserProfileRepository implements UserProfileRepository {
  UserProfile _profile = UserProfile(
    id: '1',
    name: 'Omar Ahmed',
    email: 'omar@example.com',
    imageUrl: 'mobile/Flutter.png',
    bio: 'Flutter Developer',
  );

  @override
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _profile;
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _profile = profile;
  }
}
