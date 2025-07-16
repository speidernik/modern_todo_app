import 'package:flutter/material.dart';
import 'package:modern_todo_app/features/settings/models/account_settings.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountSettingsService = AccountSettingsService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCurrentSettings();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentSettings() async {
    try {
      final settings = await _accountSettingsService.getCurrentSettings();
      setState(() {
        _usernameController.text = settings.username;
        _emailController.text = settings.email;
      });
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'errorUpdatingSettings',
          params: {'error': e.toString()},
        );
      });
    }
  }

  Future<void> _updateUsername() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _accountSettingsService.updateUsername(_usernameController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'settingsUpdated')),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'errorUpdatingSettings',
          params: {'error': e.toString()},
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _accountSettingsService.updateEmail(
        _emailController.text,
        _currentPasswordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'settingsUpdated')),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'errorUpdatingSettings',
          params: {'error': e.toString()},
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _accountSettingsService.updatePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TranslationService.tr(context, 'settingsUpdated')),
          ),
        );
      }
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = TranslationService.tr(
          context,
          'errorUpdatingSettings',
          params: {'error': e.toString()},
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
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'accountSettings')),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TranslationService.tr(context, 'updateUsername'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText:
                                    TranslationService.tr(context, 'username'),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {'error': 'Username is required'},
                                  );
                                }
                                if (value.length < 3) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error':
                                          'Username must be at least 3 characters'
                                    },
                                  );
                                }
                                if (!RegExp(r'^[a-zA-Z0-9_]+$')
                                    .hasMatch(value)) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error':
                                          'Username can only contain letters, numbers, and underscores'
                                    },
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _updateUsername,
                              child: Text(TranslationService.tr(
                                  context, 'updateUsername')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TranslationService.tr(context, 'updateEmail'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText:
                                    TranslationService.tr(context, 'email'),
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {'error': 'Email is required'},
                                  );
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                    .hasMatch(value)) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error': 'Please enter a valid email'
                                    },
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _currentPasswordController,
                              decoration: InputDecoration(
                                labelText: TranslationService.tr(
                                    context, 'currentPassword'),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error': 'Current password is required'
                                    },
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _updateEmail,
                              child: Text(TranslationService.tr(
                                  context, 'updateEmail')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TranslationService.tr(context, 'updatePassword'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _newPasswordController,
                              decoration: InputDecoration(
                                labelText: TranslationService.tr(
                                    context, 'newPassword'),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error': 'New password is required'
                                    },
                                  );
                                }
                                if (value.length < 6) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error':
                                          'Password must be at least 6 characters'
                                    },
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                labelText: TranslationService.tr(
                                    context, 'confirmPassword'),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {
                                      'error':
                                          'Please confirm your new password'
                                    },
                                  );
                                }
                                if (value != _newPasswordController.text) {
                                  return TranslationService.tr(
                                    context,
                                    'errorUpdatingSettings',
                                    params: {'error': 'Passwords do not match'},
                                  );
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _updatePassword,
                              child: Text(TranslationService.tr(
                                  context, 'updatePassword')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
