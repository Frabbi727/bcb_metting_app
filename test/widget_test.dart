import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bcb_meeting_app/main.dart';
import 'package:bcb_meeting_app/core/values/env_config.dart';
import 'package:bcb_meeting_app/data/local/local_storage.dart';

void main() {
  testWidgets('App launches and displays home title', (WidgetTester tester) async {
    // Initialize storage for testing
    await GetStorage.init();
    
    // Inject EnvConfig for testing
    Get.put<EnvConfig>(const EnvConfig(
      environment: Environment.development,
      baseUrl: 'https://api.dev.example.com/v1',
      appTitle: 'BCB App [DEV]',
    ), permanent: true);

    final localStorage = LocalStorageService();
    await localStorage.init();
    Get.put<LocalStorageService>(localStorage, permanent: true);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that the home view renders with the correct title.
    expect(find.text('BCB Base Project'), findsOneWidget);
    
    // Clean up Get instances
    Get.reset();
  });
}
