import 'core/values/api_endpoints.dart';
import 'core/values/env_config.dart';
import 'main.dart' as app;

void main() async {
  await app.mainCommon(const EnvConfig(
    environment: Environment.staging,
    baseUrl: ApiEndPoints.stagingBaseUrl,
    appTitle: 'BCB App [STG]',
  ));
}
