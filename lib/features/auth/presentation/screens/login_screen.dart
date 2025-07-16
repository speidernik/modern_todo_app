import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/auth/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLogin = true;
  bool _obscurePassword = true;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message;
        switch (e.code) {
          case 'user-not-found':
            message = TranslationService.tr(context, 'userNotFound');
            break;
          case 'wrong-password':
            message = TranslationService.tr(context, 'wrongPassword');
            break;
          case 'email-already-in-use':
            message = TranslationService.tr(context, 'emailInUse');
            break;
          case 'weak-password':
            message = TranslationService.tr(context, 'weakPassword');
            break;
          case 'invalid-email':
            message = TranslationService.tr(context, 'invalidEmail');
            break;
          default:
            message =
                e.message ?? TranslationService.tr(context, 'errorOccurred');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: theme.colorScheme.primary,
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .rotate(duration: const Duration(seconds: 2)),
                    const SizedBox(height: 48),
                    Text(
                      _isLogin
                          ? TranslationService.tr(context, 'welcomeBack')
                          : TranslationService.tr(context, 'createAccount'),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(duration: const Duration(milliseconds: 500))
                        .slideY(begin: 0.3),
                    const SizedBox(height: 8),
                    Text(
                      _isLogin
                          ? TranslationService.tr(context, 'loginSubtitle')
                          : TranslationService.tr(context, 'signupSubtitle'),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 200)),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: _emailController,
                      hintText: TranslationService.tr(context, 'enterEmail'),
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TranslationService.tr(context, 'enterEmail');
                        }
                        if (!value.contains('@')) {
                          return TranslationService.tr(context, 'validEmail');
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 300)),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: TranslationService.tr(context, 'password'),
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TranslationService.tr(
                              context, 'enterPassword');
                        }
                        if (value.length < 6) {
                          return TranslationService.tr(
                              context, 'passwordLength');
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 400)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              _isLogin
                                  ? TranslationService.tr(context, 'login')
                                  : TranslationService.tr(context, 'signup'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 500)),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(
                        _isLogin
                            ? TranslationService.tr(context, 'dontHaveAccount')
                            : TranslationService.tr(
                                context, 'alreadyHaveAccount'),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 800)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
