import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/bindings/initial_binding.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'core/values/api_endpoints.dart';
import 'core/values/app_translations.dart';
import 'core/values/env_config.dart';
import 'data/local/local_storage.dart';

void main() async {
  // Default to production environment
  await mainCommon(const EnvConfig(
    environment: Environment.production,
    baseUrl: ApiEndPoints.prodBaseUrl,
    appTitle: 'BCB Meeting App',
  ));
}

Future<void> mainCommon(EnvConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Pre-initialize and register LocalStorageService
  final localStorage = LocalStorageService();
  await localStorage.init();
  Get.put<LocalStorageService>(localStorage, permanent: true);

  // Inject EnvConfig globally
  Get.put<EnvConfig>(config, permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final env = Get.find<EnvConfig>();
    final localStorage = Get.find<LocalStorageService>();

    return GetMaterialApp(
      title: env.appTitle,
      debugShowCheckedModeBanner: env.environment != Environment.production,
      
      // Theme Setup
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _getInitialThemeMode(localStorage),

      // Localization Setup
      translations: AppTranslations(),
      locale: _getInitialLocale(localStorage),
      fallbackLocale: const Locale('en', 'US'),

      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
    );
  }

  Locale _getInitialLocale(LocalStorageService storage) {
    final lang = storage.languageCode;
    final country = storage.countryCode;
    if (lang != null) {
      return Locale(lang, country);
    }
    return Get.deviceLocale ?? const Locale('en', 'US');
  }

  ThemeMode _getInitialThemeMode(LocalStorageService storage) {
    final mode = storage.themeMode;
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
