// 🌐 Language Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LanguageCubit extends Cubit<Locale> {
  final StorageService storageService;
  
  LanguageCubit({required this.storageService}) 
    : super(const Locale('en')) {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final languageCode = storageService.getString('language') ?? 'en';
    emit(Locale(languageCode));
  }
  
  Future<void> changeLanguage(String languageCode) async {
    emit(Locale(languageCode));
    await storageService.setString('language', languageCode);
  }
}
