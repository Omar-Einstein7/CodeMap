import 'dart:convert';
import 'package:codemap2/src/services/secure_token_storage.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<void> cacheToken(String token);
  Future<String?> getToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final SecureTokenStorage secureTokenStorage;
  static const String _cachedUserKey = 'cached_user';

  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.secureTokenStorage,
  });

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
      _cachedUserKey,
      json.encode(user.toJson()),
    );
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(_cachedUserKey);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(_cachedUserKey);
    await secureTokenStorage.deleteToken();
  }

  @override
  Future<void> cacheToken(String token) async {
    await secureTokenStorage.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await secureTokenStorage.getToken();
  }
}
