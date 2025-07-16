import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:modern_todo_app/features/settings/models/account_settings.dart';

part 'settings_provider.g.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AsyncValue<AppSettings>>((ref) {
  return SettingsNotifier();
});

class AppSettings {
  final ThemeMode themeMode;
  final String locale;
  final AccountSettings? accountSettings;

  AppSettings({
    required this.themeMode,
    required this.locale,
    this.accountSettings,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? locale,
    AccountSettings? accountSettings,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      accountSettings: accountSettings ?? this.accountSettings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode.toString().split('.').last,
      'locale': locale,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.toString().split('.').last == map['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      locale: map['locale'] as String? ?? 'en',
    );
  }
}

class SettingsNotifier extends StateNotifier<AsyncValue<AppSettings>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SettingsNotifier() : super(const AsyncValue.loading()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        state = AsyncValue.data(AppSettings(
          themeMode: ThemeMode.system,
          locale: TranslationService.defaultLocale.languageCode,
        ));
        return;
      }

      final settingsDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('app_settings')
          .get();

      final accountDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!settingsDoc.exists) {
        // Create default settings
        final defaultSettings = AppSettings(
          themeMode: ThemeMode.system,
          locale: TranslationService.defaultLocale.languageCode,
        );
        await settingsDoc.reference.set(defaultSettings.toMap());
        state = AsyncValue.data(defaultSettings);
        return;
      }

      state = AsyncValue.data(AppSettings.fromMap(settingsDoc.data()!)
        ..copyWith(
          accountSettings: accountDoc.exists
              ? AccountSettings.fromMap(accountDoc.data()!)
              : null,
        ));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final settings = state.value;
      if (settings == null) return;

      final newSettings = settings.copyWith(themeMode: themeMode);
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('app_settings')
          .set(newSettings.toMap());

      state = AsyncValue.data(newSettings);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLocale(String locale) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final settings = state.value;
      if (settings == null) return;

      final newSettings = settings.copyWith(locale: locale);
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('app_settings')
          .set(newSettings.toMap());

      state = AsyncValue.data(newSettings);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refreshSettings() async {
    await _loadSettings();
  }
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await saveSettings();
  }

  Future<void> saveSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final themeMode = state;
    final locale = ref.read(localeNotifierProvider);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('preferences')
          .set({
        'themeMode': themeMode.name,
        'locale': locale.languageCode,
      });
    } catch (e) {
      debugPrint('Error saving settings: $e');
    }
  }
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Listen to user settings changes
    ref.listen(userSettingsProvider, (previous, next) {
      next.whenData((settings) {
        final localeStr = settings['locale'] as String?;
        if (localeStr != null) {
          final newLocale = Locale(localeStr);
          if (state != newLocale) {
            state = newLocale;
          }
        }
      });
    });

    return TranslationService.defaultLocale;
  }

  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;

    state = locale;
    await saveSettings();
  }

  Future<void> saveSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final themeMode = ref.read(themeModeNotifierProvider);
    final locale = state;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('preferences')
          .set({'themeMode': themeMode.name, 'locale': locale.languageCode});
    } catch (e) {
      debugPrint('Error saving settings: $e');
    }
  }
}

/// Stream provider that listens to user settings changes
@riverpod
Stream<Map<String, dynamic>> userSettings(ref) async* {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    yield {};
    return;
  }

  await for (final snapshot in FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('settings')
      .doc('preferences')
      .snapshots()) {
    yield snapshot.data() ?? {};
  }
}

/// Initialize user settings when logging in
Future<void> initializeUserSettings(WidgetRef ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('settings')
        .doc('preferences')
        .get();

    if (!doc.exists) {
      // Save default settings if none exist
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('preferences')
          .set({
        'themeMode': ThemeMode.system.name,
        'locale': TranslationService.defaultLocale.languageCode,
      });
    } else {
      final data = doc.data()!;

      // Set theme mode
      final themeModeStr = data['themeMode'] as String?;
      if (themeModeStr != null) {
        final themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.name == themeModeStr,
          orElse: () => ThemeMode.system,
        );
        ref.read(themeModeNotifierProvider.notifier).setThemeMode(themeMode);
      }

      // Set locale
      final localeStr = data['locale'] as String?;
      if (localeStr != null) {
        final locale = Locale(localeStr);
        ref.read(localeNotifierProvider.notifier).setLocale(locale);
      }
    }
  } catch (e) {
    debugPrint('Error initializing settings: $e');
  }
}
