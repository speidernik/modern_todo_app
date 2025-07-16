import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSecuritySection extends StatefulWidget {
  const AccountSecuritySection({super.key});

  @override
  State<AccountSecuritySection> createState() => _AccountSecuritySectionState();
}

class _AccountSecuritySectionState extends State<AccountSecuritySection> {
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _changeCurrentPasswordOldController = TextEditingController();
  final _changeCurrentPasswordNewController = TextEditingController();
  final _changeCurrentPasswordConfirmController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _changeCurrentPasswordOldController.dispose();
    _changeCurrentPasswordNewController.dispose();
    _changeCurrentPasswordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    _emailController.text = user?.email ?? '';
  }

  Future<void> _updateEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user signed in');
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: _currentPasswordController.text);
      await user.reauthenticateWithCredential(cred);
      await user.updateEmail(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email updated successfully')));
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user signed in');
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: _currentPasswordController.text);
      await user.reauthenticateWithCredential(cred);
      if (_newPasswordController.text != _confirmPasswordController.text) {
        throw Exception('Passwords do not match');
      }
      await user.updatePassword(_newPasswordController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')));
      }
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _changeCurrentPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user signed in');
      final cred = EmailAuthProvider.credential(
          email: user.email!,
          password: _changeCurrentPasswordOldController.text);
      await user.reauthenticateWithCredential(cred);
      if (_changeCurrentPasswordNewController.text !=
          _changeCurrentPasswordConfirmController.text) {
        throw Exception('Passwords do not match');
      }
      await user.updatePassword(_changeCurrentPasswordNewController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully')));
      }
      _changeCurrentPasswordOldController.clear();
      _changeCurrentPasswordNewController.clear();
      _changeCurrentPasswordConfirmController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(_errorMessage!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Change Email',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'New Email',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _currentPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'Current Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: _updateEmail,
                          child: const Text('Update Email')),
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
                      const Text('Change Password',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _newPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'Confirm New Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: _updatePassword,
                          child: const Text('Update Password')),
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
                      const Text('Change Current Password',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _changeCurrentPasswordOldController,
                        decoration: const InputDecoration(
                            labelText: 'Current Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _changeCurrentPasswordNewController,
                        decoration: const InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _changeCurrentPasswordConfirmController,
                        decoration: const InputDecoration(
                            labelText: 'Confirm New Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: _changeCurrentPassword,
                          child: const Text('Change Password')),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
