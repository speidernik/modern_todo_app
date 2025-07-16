import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/settings/presentation/widgets/account_security_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'settings')),
      ),
      body: settingsAsync.when(
        data: (settings) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Settings Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TranslationService.tr(context, 'appSettings'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Theme Mode
                      Text(TranslationService.tr(context, 'themeMode')),
                      const SizedBox(height: 8),
                      SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.system,
                            label:
                                Text(TranslationService.tr(context, 'system')),
                            icon: const Icon(Icons.brightness_auto),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.light,
                            label:
                                Text(TranslationService.tr(context, 'light')),
                            icon: const Icon(Icons.brightness_high),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.dark,
                            label: Text(TranslationService.tr(context, 'dark')),
                            icon: const Icon(Icons.brightness_4),
                          ),
                        ],
                        selected: {settings.themeMode},
                        onSelectionChanged: (Set<ThemeMode> selected) {
                          ref.read(settingsProvider.notifier).updateThemeMode(
                                selected.first,
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Language
                      Text(TranslationService.tr(context, 'language')),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: [
                          ButtonSegment<String>(
                            value: 'en',
                            label:
                                Text(TranslationService.tr(context, 'english')),
                          ),
                          ButtonSegment<String>(
                            value: 'de',
                            label:
                                Text(TranslationService.tr(context, 'german')),
                          ),
                          ButtonSegment<String>(
                            value: 'es',
                            label:
                                Text(TranslationService.tr(context, 'spanish')),
                          ),
                        ],
                        selected: {settings.locale},
                        onSelectionChanged: (Set<String> selected) {
                          ref.read(settingsProvider.notifier).updateLocale(
                                selected.first,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Account Security Section
              const AccountSecuritySection(),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(TranslationService.tr(
            context,
            'errorUpdatingSettings',
            params: {'error': error.toString()},
          )),
        ),
      ),
    );
  }
}
