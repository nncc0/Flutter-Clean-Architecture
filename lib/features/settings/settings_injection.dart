// ⚙️ Settings Feature Injection
import '../../core/services/locator_service.dart';
import '../../core/theme/theme_cubit.dart';
import '../../core/l10n/language_cubit.dart';
import 'presentation/cubit/settings_cubit.dart';

Future<void> initSettingsFeature() async {
  // Cubit
  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      themeCubit: getIt<ThemeCubit>(),
      languageCubit: getIt<LanguageCubit>(),
    ),
  );
}
