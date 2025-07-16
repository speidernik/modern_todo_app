import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/settings/providers/settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/features/chat/services/encryption_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final locale = ref.watch(localeNotifierProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'settings')),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            children: [
              // User Settings Button (large, full-width, no card)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.person, size: 28),
                  label: Text(TranslationService.tr(context, 'userSettings')),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UserSettingsScreen(),
                      ),
                    );
                  },
                ),
              ).animate().fadeIn().slideX(),

              const SizedBox(height: 16),

              // Theme Section
              _SettingsCard(
                title: TranslationService.tr(context, 'themeMode'),
                icon: Icons.palette_outlined,
                child: SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: const Icon(Icons.brightness_auto),
                      label: Text(TranslationService.tr(context, 'system')),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: const Icon(Icons.light_mode),
                      label: Text(TranslationService.tr(context, 'light')),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: const Icon(Icons.dark_mode),
                      label: Text(TranslationService.tr(context, 'dark')),
                    ),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (Set<ThemeMode> newSelection) {
                    ref
                        .read(themeModeNotifierProvider.notifier)
                        .setThemeMode(newSelection.first);
                  },
                ),
              ).animate().fadeIn().slideX(),

              const SizedBox(height: 16),

              // Language Section
              _SettingsCard(
                title: TranslationService.tr(context, 'language'),
                icon: Icons.language,
                child: SegmentedButton<Locale>(
                  segments: [
                    ButtonSegment(
                      value: const Locale('en'),
                      label: Text(TranslationService.tr(context, 'english')),
                    ),
                    ButtonSegment(
                      value: const Locale('de'),
                      label: Text(TranslationService.tr(context, 'german')),
                    ),
                    ButtonSegment(
                      value: const Locale('es'),
                      label: Text(TranslationService.tr(context, 'spanish')),
                    ),
                  ],
                  selected: {locale},
                  onSelectionChanged: (Set<Locale> newSelection) {
                    ref
                        .read(localeNotifierProvider.notifier)
                        .setLocale(newSelection.first);
                  },
                ),
              ).animate().fadeIn().slideX(),

              const SizedBox(height: 16),

              // About Section
              _SettingsCard(
                title: TranslationService.tr(context, 'about'),
                icon: Icons.info_outline,
                child: Column(
                  children: [
                    _SettingsTile(
                      title: TranslationService.tr(context, 'version'),
                      icon: Icons.tag,
                      trailing: const Text('1.0.0'),
                    ),
                    _SettingsTile(
                      title: TranslationService.tr(context, 'sourceCode'),
                      icon: Icons.code,
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () {
                        // Launch the repository URL
                        launchUrl(
                            Uri.parse('https://codeberg.org/Speidernik/MyApp'));
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget child;

  const _SettingsCard({this.title, this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && icon != null) ...[
              Row(
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 20),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'userSettings')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _SettingsCard(
              title: TranslationService.tr(context, 'changeUsername'),
              icon: Icons.person,
              child: _ChangeUsernameForm(),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              title: TranslationService.tr(context, 'changePassword'),
              icon: Icons.lock_outline,
              child: _ChangePasswordForm(),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              title: TranslationService.tr(context, 'changeEmail'),
              icon: Icons.email_outlined,
              child: _ChangeEmailForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception(TranslationService.tr(context, 'noUserSignedIn'));
      }

      // Verify current password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(_newPasswordController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'passwordChanged')),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'failedToChangePassword',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_errorMessage != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ),
        TextField(
          controller: _currentPasswordController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'currentPassword'),
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _newPasswordController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'newPassword'),
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'confirmNewPassword'),
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : _changePassword,
          child: _isLoading
              ? const CircularProgressIndicator()
              : Text(TranslationService.tr(context, 'changePassword')),
        ),
      ],
    );
  }
}

class _ChangeEmailForm extends StatefulWidget {
  @override
  State<_ChangeEmailForm> createState() => _ChangeEmailFormState();
}

class _ChangeEmailFormState extends State<_ChangeEmailForm> {
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _emailController.text = user?.email ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changeEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception(TranslationService.tr(context, 'noUserSignedIn'));
      }

      // Verify current password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      // Change email
      await user.updateEmail(_emailController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'emailChanged')),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'failedToChangeEmail',
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_errorMessage != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'email'),
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _currentPasswordController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'currentPassword'),
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : _changeEmail,
          child: _isLoading
              ? const CircularProgressIndicator()
              : Text(TranslationService.tr(context, 'changeEmail')),
        ),
      ],
    );
  }
}

class _ChangeUsernameForm extends StatefulWidget {
  @override
  State<_ChangeUsernameForm> createState() => _ChangeUsernameFormState();
}

class _ChangeUsernameFormState extends State<_ChangeUsernameForm> {
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCurrentUsername();
  }

  Future<void> _loadCurrentUsername() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final encrypted = doc.data()?['username'] ?? '';
      if (encrypted.isNotEmpty) {
        _usernameController.text = EncryptionService.decryptText(encrypted);
      } else {
        _usernameController.text = '';
      }
    } catch (e) {
      // ignore error, just leave field blank
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _changeUsername() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null)
        throw Exception(TranslationService.tr(context, 'noUserSignedIn'));
      final newUsername = _usernameController.text.trim();
      if (newUsername.isEmpty) {
        setState(() {
          _errorMessage =
              TranslationService.tr(context, 'usernameCannotBeEmpty');
        });
        return;
      }
      final encryptedUsername = EncryptionService.encryptText(newUsername);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'username': encryptedUsername}, SetOptions(merge: true));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'usernameChanged')),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            TranslationService.tr(context, 'failedToChangeUsername');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_errorMessage != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: TranslationService.tr(context, 'username'),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : _changeUsername,
          child: _isLoading
              ? const CircularProgressIndicator()
              : Text(TranslationService.tr(context, 'changeUsername')),
        ),
      ],
    );
  }
}
