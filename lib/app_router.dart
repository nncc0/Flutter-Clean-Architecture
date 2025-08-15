// 🛣️ App Router
import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/utils/extensions.dart';
import 'package:flutter_application_2/core/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'core/services/navigation_service.dart';
import 'core/services/locator_service.dart';
import 'features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: getIt<NavigationService>().navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Home Page'),
              const SizedBox(height: 20),
              CustomButton(
                text: "sajsrhfjs",
                onPressed: () {
                  'hello world'.isValidEmail; // Example usage
                },

              ),
              // زر بسيط
CustomButton(
  text: 'اضغط هنا',
  onPressed: () {},
),



              const SizedBox(height: 20),
              CustomButton(
                text: 'Go to Settings',
                onPressed: () {
                  context.push('/settings');
                },
                
              ),
            ],
          ),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Auth Page')),
        ),
      ),
    ],
  );
}
