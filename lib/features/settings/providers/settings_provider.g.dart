// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSettingsHash() => r'e4e91b253d0c3f52ce6c2749cc4a0d27698bbe9b';

/// Stream provider that listens to user settings changes
///
/// Copied from [userSettings].
@ProviderFor(userSettings)
final userSettingsProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  userSettings,
  name: r'userSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSettingsRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$themeModeNotifierHash() => r'509085b5b91c93925b4d507917e09dd6c6ca890a';

/// See also [ThemeModeNotifier].
@ProviderFor(ThemeModeNotifier)
final themeModeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeModeNotifier, ThemeMode>.internal(
  ThemeModeNotifier.new,
  name: r'themeModeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeModeNotifier = AutoDisposeNotifier<ThemeMode>;
String _$localeNotifierHash() => r'cc3ecf450d8db9e64aefa4cde8f3cf5927f2a106';

/// See also [LocaleNotifier].
@ProviderFor(LocaleNotifier)
final localeNotifierProvider =
    AutoDisposeNotifierProvider<LocaleNotifier, Locale>.internal(
  LocaleNotifier.new,
  name: r'localeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocaleNotifier = AutoDisposeNotifier<Locale>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
