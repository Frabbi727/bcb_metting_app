import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/values/constants.dart';
import '../../core/values/env_config.dart';
import '../local/local_storage.dart';
import 'api_interceptors.dart';

class ApiClient {
  late final Dio dio;

  ApiClient(LocalStorageService storage) {
    final env = Get.find<EnvConfig>();
    
    dio = Dio(
      BaseOptions(
        baseUrl: env.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(ApiInterceptor(storage));
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
  }
}
