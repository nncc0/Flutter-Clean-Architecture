// 💾 Storage Service
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _prefs;
  bool _initialized = false;
  
  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw StateError('StorageService must be initialized before use. Call init() first.');
    }
  }
  
  // Generic methods
  Future<bool> set<T>(String key, T value) async {
    _checkInitialized();
    switch (T) {
      case String:
        return await _prefs.setString(key, value as String);
      case int:
        return await _prefs.setInt(key, value as int);
      case bool:
        return await _prefs.setBool(key, value as bool);
      case double:
        return await _prefs.setDouble(key, value as double);
      case const (List<String>):
        return await _prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Unsupported type');
    }
  }
  
  T? get<T>(String key) {
    _checkInitialized();
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case const (List<String>):
        return _prefs.getStringList(key) as T?;
      default:
        return null;
    }
  }
  
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  Future<bool> clear() async {
    return await _prefs.clear();
  }
  
  // Convenience methods
  Future<bool> setString(String key, String value) => set<String>(key, value);
  String? getString(String key) => get<String>(key);
  
  Future<bool> setInt(String key, int value) => set<int>(key, value);
  int? getInt(String key) => get<int>(key);
  
  Future<bool> setBool(String key, bool value) => set<bool>(key, value);
  bool? getBool(String key) => get<bool>(key);
  
  Future<bool> setDouble(String key, double value) => set<double>(key, value);
  double? getDouble(String key) => get<double>(key);
  
  Future<bool> setStringList(String key, List<String> value) => set<List<String>>(key, value);
  List<String>? getStringList(String key) => get<List<String>>(key);
}
