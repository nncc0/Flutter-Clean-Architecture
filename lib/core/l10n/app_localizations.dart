// 🌐 App Localizations
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
      
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  
  final Map<String, String> _localizedStrings;
  
  AppLocalizations(this._localizedStrings);
  
  // Common strings
  String get appName => _localizedStrings['app_name'] ?? 'Flutter App';
  String get welcome => _localizedStrings['welcome'] ?? 'Welcome';
  String get loading => _localizedStrings['loading'] ?? 'Loading...';
  String get error => _localizedStrings['error'] ?? 'Error';
  String get retry => _localizedStrings['retry'] ?? 'Retry';
  String get cancel => _localizedStrings['cancel'] ?? 'Cancel';
  String get confirm => _localizedStrings['confirm'] ?? 'Confirm';
  String get ok => _localizedStrings['ok'] ?? 'OK';
  String get yes => _localizedStrings['yes'] ?? 'Yes';
  String get no => _localizedStrings['no'] ?? 'No';
  
  // Settings
  String get settings => _localizedStrings['settings'] ?? 'Settings';
  String get theme => _localizedStrings['theme'] ?? 'Theme';
  String get language => _localizedStrings['language'] ?? 'Language';
  String get lightTheme => _localizedStrings['light_theme'] ?? 'Light';
  String get darkTheme => _localizedStrings['dark_theme'] ?? 'Dark';
  String get systemTheme => _localizedStrings['system_theme'] ?? 'System';
  String get english => _localizedStrings['english'] ?? 'English';
  String get arabic => _localizedStrings['arabic'] ?? 'Arabic';
  
  // Navigation
  String get backToHome => _localizedStrings['back_to_home'] ?? 'Back to Home';
  String get home => _localizedStrings['home'] ?? 'Home';
  String get profile => _localizedStrings['profile'] ?? 'Profile';
  
  // Auth
  String get login => _localizedStrings['login'] ?? 'Login';
  String get register => _localizedStrings['register'] ?? 'Register';
  String get logout => _localizedStrings['logout'] ?? 'Logout';
  String get email => _localizedStrings['email'] ?? 'Email';
  String get password => _localizedStrings['password'] ?? 'Password';
  String get confirmPassword => _localizedStrings['confirm_password'] ?? 'Confirm Password';
  String get forgotPassword => _localizedStrings['forgot_password'] ?? 'Forgot Password?';
  String get invalidEmail => _localizedStrings['invalid_email'] ?? 'Please enter a valid email';
  String get invalidPassword => _localizedStrings['invalid_password'] ?? 'Password must be at least 6 characters';
  String get passwordsDoNotMatch => _localizedStrings['passwords_do_not_match'] ?? 'Passwords do not match';
  
  // Validation
  String get requiredField => _localizedStrings['required_field'] ?? 'This field is required';
  String get invalidInput => _localizedStrings['invalid_input'] ?? 'Invalid input';
  
  // Errors
  String get networkError => _localizedStrings['network_error'] ?? 'Network error. Please check your connection.';
  String get serverError => _localizedStrings['server_error'] ?? 'Server error. Please try again later.';
  String get unauthorizedError => _localizedStrings['unauthorized_error'] ?? 'Unauthorized. Please login again.';
  String get forbiddenError => _localizedStrings['forbidden_error'] ?? 'You don\'t have permission to access this resource.';
  String get notFoundError => _localizedStrings['not_found_error'] ?? 'Resource not found.';
  String get unknownError => _localizedStrings['unknown_error'] ?? 'An unknown error occurred.';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    final String jsonString = await rootBundle.loadString(
      'assets/l10n/${locale.languageCode}.json',
    );
    
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final Map<String, String> localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    
    return AppLocalizations(localizedStrings);
  }
  
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
