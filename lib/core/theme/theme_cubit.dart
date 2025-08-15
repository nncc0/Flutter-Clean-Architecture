// 🎨 Theme Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/storage_service.dart';

enum AppTheme { light, dark, system }

class ThemeCubit extends Cubit<AppTheme> {
  final StorageService storageService;
  
  ThemeCubit({required this.storageService}) : super(AppTheme.system) {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final themeIndex = storageService.getInt('theme_mode') ?? 2; // Default to system
    emit(AppTheme.values[themeIndex]);
  }
  
  Future<void> setTheme(AppTheme theme) async {
    emit(theme);
    await storageService.setInt('theme_mode', theme.index);
  }
}
