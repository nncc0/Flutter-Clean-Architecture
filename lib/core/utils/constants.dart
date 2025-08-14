// 🔧 App Constants
class AppConstants {
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int defaultPageSize = 20;
  static const List<String> supportedLocales = ['en', 'ar'];
  
  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // API endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String userProfileEndpoint = '/user/profile';
}
