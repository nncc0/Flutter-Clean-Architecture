// 🔧 Extensions
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
  
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
  
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
  
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  String get capitalizeFirstOfEach {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }
  
  bool get isValidPassword {
    return length >= 6;
  }
  
  String formatDate({String format = 'yyyy-MM-dd'}) {
    try {
      final date = DateTime.parse(this);
      return DateFormat(format).format(date);
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeExtensions on DateTime {
  String format({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(this);
  }
}
