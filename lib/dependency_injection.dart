// 🔄 Dependency Injection Setup
import 'features/settings/settings_injection.dart';

Future<void> initializeDependencies() async {
  
  // Register features
  await initSettingsFeature();
  // Example:
  // await initAuthFeature();
  // await initUserProfileFeature();
}
