class AppConstants {
  AppConstants._();

  // Storage Keys
  static const String keyToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserInfo = 'user_info';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguageCode = 'language_code';
  static const String keyCountryCode = 'country_code';

  // Network configuration
  static const int connectTimeout = 15000; // milliseconds
  static const int receiveTimeout = 15000; // milliseconds
}
