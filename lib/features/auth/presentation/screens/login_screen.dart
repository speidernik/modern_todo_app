import 'dart:ui';

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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Animated, vibrant gradient background with glassmorphism overlay
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0F2027),
                  const Color(0xFF2C5364),
                  const Color(0xFF1A2980),
                  const Color(0xFF43CEA2),
                  const Color(0xFF185A9D),
                ],
                stops: [0.0, 0.3, 0.6, 0.8, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated glowing shapes
                Positioned(
                  top: 60,
                  left: 30,
                  child: AnimatedContainer(
                    duration: 1200.ms,
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.cyanAccent.withOpacity(0.18),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 40,
                  child: AnimatedContainer(
                    duration: 1200.ms,
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.15),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                  child: Container(
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.18),
                              blurRadius: 32,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 80,
                              color: theme.colorScheme.primary,
                              shadows: [
                                Shadow(
                                  color: Colors.cyanAccent.withOpacity(0.4),
                                  blurRadius: 24,
                                ),
                              ],
                            )
                                .animate(
                                    onPlay: (controller) => controller.repeat())
                                .rotate(duration: const Duration(seconds: 2)),
                            const SizedBox(height: 32),
                            Text(
                              _isLogin
                                  ? TranslationService.tr(
                                      context, 'welcomeBack')
                                  : TranslationService.tr(
                                      context, 'createAccount'),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 32,
                                letterSpacing: 1.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                                .animate()
                                .fadeIn(
                                    duration: const Duration(milliseconds: 500))
                                .slideY(begin: 0.3),
                            const SizedBox(height: 8),
                            Text(
                              _isLogin
                                  ? TranslationService.tr(
                                      context, 'loginSubtitle')
                                  : TranslationService.tr(
                                      context, 'signupSubtitle'),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(
                                delay: const Duration(milliseconds: 200)),
                            const SizedBox(height: 32),
                            CustomTextField(
                              controller: _emailController,
                              hintText:
                                  TranslationService.tr(context, 'enterEmail'),
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TranslationService.tr(
                                      context, 'enterEmail');
                                }
                                if (!value.contains('@')) {
                                  return TranslationService.tr(
                                      context, 'validEmail');
                                }
                                return null;
                              },
                            ).animate().fadeIn(
                                delay: const Duration(milliseconds: 300)),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _passwordController,
                              hintText:
                                  TranslationService.tr(context, 'password'),
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
                            ).animate().fadeIn(
                                delay: const Duration(milliseconds: 400)),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => _isLoading = true),
                              onTapUp: (_) =>
                                  setState(() => _isLoading = false),
                              child: AnimatedContainer(
                                duration: 200.ms,
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: _isLoading
                                      ? [
                                          BoxShadow(
                                            color: Colors.cyanAccent
                                                .withOpacity(0.4),
                                            blurRadius: 32,
                                            offset: const Offset(0, 8),
                                          ),
                                        ]
                                      : [
                                          BoxShadow(
                                            color: Colors.cyanAccent
                                                .withOpacity(0.18),
                                            blurRadius: 16,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    backgroundColor: theme.colorScheme.primary,
                                    elevation: 8,
                                    shadowColor:
                                        Colors.cyanAccent.withOpacity(0.2),
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
                                              ? TranslationService.tr(
                                                  context, 'login')
                                              : TranslationService.tr(
                                                  context, 'signup'),
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                ),
                              ),
                            ).animate().fadeIn(
                                delay: const Duration(milliseconds: 500)),
                            const SizedBox(height: 24),
                            TextButton(
                              onPressed: () =>
                                  setState(() => _isLogin = !_isLogin),
                              child: Text(
                                _isLogin
                                    ? TranslationService.tr(
                                        context, 'dontHaveAccount')
                                    : TranslationService.tr(
                                        context, 'alreadyHaveAccount'),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.cyanAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ).animate().fadeIn(
                                delay: const Duration(milliseconds: 800)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
