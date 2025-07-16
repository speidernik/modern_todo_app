import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/auth/presentation/screens/login_screen.dart';
import 'package:modern_todo_app/features/home/presentation/screens/home_menu_screen.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';

class AppRouter extends ConsumerStatefulWidget {
  const AppRouter({super.key});

  @override
  ConsumerState<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends ConsumerState<AppRouter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading indicator while waiting for auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If we have a user, initialize settings and show the home menu screen
        if (snapshot.hasData) {
          // Initialize user settings when logged in
          WidgetsBinding.instance.addPostFrameCallback((_) {
            initializeUserSettings(ref);
          });
          return const HomeMenuScreen();
        }

        // Otherwise, show the login screen
        return const LoginScreen();
      },
    );
  }
}
