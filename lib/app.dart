import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';
import 'package:modern_todo_app/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return settingsAsync.when(
      data: (settings) => MaterialApp(
        title: TranslationService.tr(context, 'appName'),
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: settings.themeMode,
        localizationsDelegates: TranslationService.localizationsDelegates,
        supportedLocales: TranslationService.supportedLocales,
        locale: Locale(settings.locale),
        home: const MainMenuPage(),
      ),
      loading: () => MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
