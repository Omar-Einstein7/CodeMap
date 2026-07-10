import '../entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
}
