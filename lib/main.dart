import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/bindings/initial_binding.dart';
import 'core/routes/app_pages.dart';
import 'core/values/env_config.dart';
import 'data/local/local_storage.dart';

void main() async {
  // Default to production environment
  await mainCommon(const EnvConfig(
    environment: Environment.production,
    baseUrl: 'https://api.example.com/v1',
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
    return GetMaterialApp(
      title: env.appTitle,
      debugShowCheckedModeBanner: env.environment != Environment.production,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
    );
  }
}
