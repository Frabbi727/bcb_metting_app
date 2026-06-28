import 'core/values/env_config.dart';
import 'main.dart' as app;

void main() async {
  await app.mainCommon(const EnvConfig(
    environment: Environment.production,
    baseUrl: 'https://api.example.com/v1',
    appTitle: 'BCB Meeting App',
  ));
}
