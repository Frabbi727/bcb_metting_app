import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_pages.dart';
import '../../data/local/local_storage.dart';
import '../../data/models/user_model.dart';
import '../../data/network/resource.dart';
import 'login_repository.dart';

class LoginController extends GetxController {
  final ILoginRepository _repository;
  final LocalStorageService _storage = Get.find<LocalStorageService>();

  LoginController(this._repository);

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool obscurePassword = true.obs;
  
  final RxBool isDarkTheme = false.obs;
  final RxBool isBangla = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkTheme.value = _storage.themeMode == 'dark';
    isBangla.value = _storage.languageCode == 'bn';
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleTheme(bool value) {
    isDarkTheme.value = value;
    final targetMode = value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(targetMode);
    _storage.saveThemeMode(value ? 'dark' : 'light');
  }

  void toggleLanguage(bool value) {
    isBangla.value = value;
    final locale = value ? const Locale('bn', 'BD') : const Locale('en', 'US');
    Get.updateLocale(locale);
    _storage.saveLocale(value ? 'bn' : 'en', value ? 'BD' : 'US');
  }

  Future<void> login(String email, String password) async {
    // Local developer fallback for showcase / offline testing
    if (email == 'admin@example.com' && password == 'password') {
      isLoading.value = true;
      errorMessage.value = '';
      await Future.delayed(const Duration(milliseconds: 800));
      await _storage.saveAccessToken('mock_access_token');
      await _storage.saveRefreshToken('mock_refresh_token');
      await _storage.saveUserInfo(UserModel(
        id: '999',
        name: 'Administrator',
        email: 'admin@example.com',
      ));
      isLoading.value = false;
      Get.offAllNamed(Routes.mainNav);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final resource = await _repository.authenticate(email, password);

    switch (resource) {
      case ResourceSuccess(data: final response):
        final accessToken = response['accessToken'] as String? ?? '';
        final refreshToken = response['refreshToken'] as String? ?? '';
        final userMap = response['user'] as Map<String, dynamic>? ?? {};

        await _storage.saveAccessToken(accessToken);
        await _storage.saveRefreshToken(refreshToken);
        await _storage.saveUserInfo(UserModel.fromJson(userMap));

        Get.offAllNamed(Routes.mainNav);
      case ResourceError(errorMessage: final message):
        errorMessage.value = message;
      case ResourceLoading():
        break;
    }

    isLoading.value = false;
  }
}
