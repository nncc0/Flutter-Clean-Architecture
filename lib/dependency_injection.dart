// 🔄 Dependency Injection Setup
import 'package:get_it/get_it.dart';
import 'core/services/locator_service.dart';
import 'features/settings/settings_injection.dart';

Future<void> initializeDependencies() async {
  await setupLocator();
  
  // Register features
  await initSettingsFeature();
  // Example:
  // await initAuthFeature();
  // await initUserProfileFeature();
}
