enum Environment { development, staging, production }

class EnvConfig {
  final Environment environment;
  final String baseUrl;
  final String appTitle;

  const EnvConfig({
    required this.environment,
    required this.baseUrl,
    required this.appTitle,
  });
}
