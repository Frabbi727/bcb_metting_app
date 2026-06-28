import 'core/values/env_config.dart';
import 'main.dart' as app;

void main() async {
  await app.mainCommon(const EnvConfig(
    environment: Environment.staging,
    baseUrl: 'https://api.staging.example.com/v1',
    appTitle: 'BCB App [STG]',
  ));
}
