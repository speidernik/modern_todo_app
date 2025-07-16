import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';

class SettingsDrawer extends ConsumerWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final locale = ref.watch(localeNotifierProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.settings,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  ref
                      .read(themeModeNotifierProvider.notifier)
                      .setThemeMode(newMode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<Locale>(
              value: locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: Locale.fromSubtags(languageCode: 'en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale.fromSubtags(languageCode: 'de'),
                  child: Text('Deutsch'),
                ),
                DropdownMenuItem(
                  value: Locale.fromSubtags(languageCode: 'es'),
                  child: Text('Español'),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'X in one',
                applicationVersion: '1.0.0',
                applicationIcon:
                    const Icon(Icons.check_circle_outline, size: 48),
                children: [
                  const Text(
                    'A X in one app with Firebase integration, animations, and multi-language support.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
