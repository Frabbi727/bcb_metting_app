abstract class ApiEndPoints {
  ApiEndPoints._();

  // Environment Base URLs
  static const String devBaseUrl = 'https://api.dev.example.com/v1';
  static const String stagingBaseUrl = 'https://api.staging.example.com/v1';
  static const String prodBaseUrl = 'https://api.example.com/v1';

  // API Endpoints
  static const String login = '/auth/login';
  static const String userProfile = '/users';
}
