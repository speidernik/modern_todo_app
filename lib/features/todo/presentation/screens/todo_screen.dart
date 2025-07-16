import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/todo/presentation/widgets/todo_list.dart';
import 'package:modern_todo_app/features/todo/presentation/widgets/todo_filters.dart';
import 'package:modern_todo_app/features/todo/presentation/widgets/todo_stats.dart';
import 'package:modern_todo_app/features/settings/presentation/screens/settings_screen.dart';

import '../../models/todo.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  late final BuildContext _context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final isTablet = MediaQuery.of(context).size.width >= 600 && !isDesktop;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
              child: Container(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Animated floating particles
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedParticles(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TranslationService.tr(context, 'todos'),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          fontFamily: 'Montserrat',
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ).animate().fadeIn().slideY(begin: 0.2),
                      IconButton(
                        icon: Icon(Icons.settings,
                            color: Colors.cyanAccent, size: 32),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()),
                        ),
                        splashRadius: 28,
                        tooltip: 'Settings',
                      ).animate().fadeIn().scale(),
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(0.13),
                    elevation: 24,
                    margin: const EdgeInsets.all(24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Modern animated filters
                          TodoFilters().animate().fadeIn().slideY(begin: 0.1),
                          const SizedBox(height: 24),
                          // Modern animated stats
                          TodoStats().animate().fadeIn().slideY(begin: 0.2),
                          const SizedBox(height: 24),
                          // Modern animated todo list
                          Expanded(
                            child: TodoList(
                              onTodoTap: (todo) {
                                // Show a modern modal or snackbar for demo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Tapped: \\${todo.title}'),
                                    backgroundColor:
                                        Colors.cyanAccent.withOpacity(0.8),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ).animate().fadeIn().slideY(begin: 0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: _showAddTodoDialog,
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add, color: Colors.white),
            ).animate().fadeIn(duration: 400.ms).scale(delay: 100.ms)
          : null,
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left sidebar with filters and stats
        Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Theme.of(_context).dividerColor,
              ),
            ),
          ),
          child: const Column(
            children: [
              TodoStats(),
              Divider(),
              TodoFilters(),
            ],
          ),
        ),
        // Main content
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: TodoList(
                  onTodoTap: _showEditTodoDialog,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left sidebar with filters
        Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Theme.of(_context).dividerColor,
              ),
            ),
          ),
          child: const TodoFilters(),
        ),
        // Main content
        Expanded(
          child: Column(
            children: [
              const TodoStats(),
              const Divider(),
              Expanded(
                child: TodoList(
                  onTodoTap: _showEditTodoDialog,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const TodoStats(),
        const TodoFilters(),
        const Divider(),
        Expanded(
          child: TodoList(
            onTodoTap: _showEditTodoDialog,
          ),
        ),
      ],
    );
  }

  void _showAddTodoDialog() async {
    if (!mounted) return;
    if (!mounted) return;
    // Handle result if needed
  }

  void _showEditTodoDialog(Todo todo) async {
    if (!mounted) return;
    if (!mounted) return;
    // Handle result if needed
  }

  void _navigateToSettings() async {
    if (!mounted) return;
    await Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
    if (!mounted) return;
    // Handle any post-navigation logic if needed
  }
}

// Add this widget at the bottom of the file if not already present
class AnimatedParticles extends StatefulWidget {
  const AnimatedParticles({super.key});

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final int _particleCount = 18;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..repeat();
    _particles = List.generate(_particleCount, (i) => _Particle(_random));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(_particles, _controller.value),
        );
      },
    );
  }
}

class _Particle {
  late double x, y, radius, speed, angle, opacity;
  late Color color;
  final Random random;

  _Particle(this.random) {
    reset();
  }

  void reset() {
    x = random.nextDouble();
    y = random.nextDouble();
    radius = random.nextDouble() * 12 + 8;
    speed = random.nextDouble() * 0.2 + 0.05;
    angle = random.nextDouble() * 2 * pi;
    opacity = random.nextDouble() * 0.3 + 0.2;
    color = Color.lerp(Colors.white, Colors.blueAccent, random.nextDouble())!
        .withOpacity(opacity);
  }

  void update(double t) {
    x += cos(angle) * speed * t * 0.5;
    y += sin(angle) * speed * t * 0.5;
    if (x < 0 || x > 1 || y < 0 || y > 1) reset();
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter(this.particles, this.progress) {
    for (final p in particles) {
      p.update(progress);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(
          Offset(p.x * size.width, p.y * size.height), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
