import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/home/presentation/screens/todo_screen.dart';
import 'package:modern_todo_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';
import 'package:modern_todo_app/features/chat/presentation/screens/chat_screen.dart';

class HomeMenuScreen extends ConsumerWidget {
  const HomeMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to locale changes
    ref.watch(localeNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              floating: true,
              pinned: true,
              title: Text(TranslationService.tr(context, 'appName')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _MenuCard(
                    title: TranslationService.tr(context, 'tasks'),
                    icon: Icons.task_alt,
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoScreen(),
                      ),
                    ),
                  ),
                  _MenuCard(
                    title: 'Chats',
                    icon: Icons.chat,
                    color: Colors.green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    ),
                  ),
                  _MenuCard(
                    title: TranslationService.tr(context, 'settings'),
                    icon: Icons.settings,
                    color: Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to locale changes
    ref.watch(localeNotifierProvider);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withValues(alpha: 0.7), color],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().scale(delay: const Duration(milliseconds: 200));
  }
}
