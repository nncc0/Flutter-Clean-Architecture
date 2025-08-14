// ⚙️ Settings Cubit
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/l10n/language_cubit.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ThemeCubit themeCubit;
  final LanguageCubit languageCubit;
  
  SettingsCubit({
    required this.themeCubit,
    required this.languageCubit,
  }) : super(SettingsInitial()) {
    _loadSettings();
  }
  
  void _loadSettings() {
    emit(state.copyWith(themeMode: themeCubit.state));
    emit(state.copyWith(locale: languageCubit.state));
  }
  
    Future<void> setTheme(AppTheme theme) async {
    await themeCubit.setTheme(theme);
    emit(state.copyWith(themeMode: theme));
  }
  
  
    Future<void> setLanguage(String languageCode) async {
    await languageCubit.changeLanguage(languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }
  
}
