// 🧭 Navigation Service
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  BuildContext get context => navigatorKey.currentContext!;
  
  void push(String location, {Object? extra}) {
    GoRouter.of(context).push(location, extra: extra);
  }
  
  void go(String location, {Object? extra}) {
    GoRouter.of(context).go(location, extra: extra);
  }
  
  void pop() {
    navigatorKey.currentState!.pop();
  }
  
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }
  
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
  
  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  
  Future<T?> showDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }
  
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
    );
  }
}
