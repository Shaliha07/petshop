import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager instance = TokenManager._privateConstructor();
  String? _accessToken;

  TokenManager._privateConstructor();

  String? get accessToken => _accessToken; // Read-only access

  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    print('Token saved: $token'); // Debugging line
  }

  Future<void> clearAccessToken() async {
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    print('Token cleared'); // Debugging line
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken') ?? null;
    print('Token loaded: $_accessToken'); // Debugging line
  }
}
