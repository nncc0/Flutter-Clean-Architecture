// ⚙️ Settings State
part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final AppTheme? themeMode;
  final Locale? locale;
  
  const SettingsState({
    this.themeMode,
    this.locale,
  });
  
  SettingsState copyWith({
    AppTheme? themeMode,
    Locale? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
  
  @override
  List<Object?> get props => [
    themeMode,
    locale,
  ];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}
