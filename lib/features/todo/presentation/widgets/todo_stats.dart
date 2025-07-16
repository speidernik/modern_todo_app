import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/todo/providers/todo_provider.dart';

class TodoStats extends ConsumerWidget {
  const TodoStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final stats = _calculateStats(todos);
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyanAccent.withOpacity(0.13),
            Colors.blueAccent.withOpacity(0.10),
            Colors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.18),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.18),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(theme, Icons.list_alt, stats['total'] ?? 0, 'Total'),
          _buildStat(
              theme, Icons.check_circle, stats['completed'] ?? 0, 'Done'),
          _buildStat(
              theme, Icons.pending_actions, stats['pending'] ?? 0, 'Pending'),
        ],
      ),
    );
  }

  Map<String, int> _calculateStats(List todos) {
    int total = todos.length;
    int completed = todos.where((t) => t.isCompleted).length;
    int pending = total - completed;
    return {'total': total, 'completed': completed, 'pending': pending};
  }

  Widget _buildStat(ThemeData theme, IconData icon, int value, String label) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.cyanAccent.withOpacity(0.22),
                Colors.blueAccent.withOpacity(0.10),
                Colors.white.withOpacity(0.08),
              ],
              center: Alignment.center,
              radius: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.22),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.cyanAccent, size: 32, shadows: [
            Shadow(
              color: Colors.cyanAccent.withOpacity(0.4),
              blurRadius: 16,
            ),
          ]),
        ),
        const SizedBox(height: 10),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: const Duration(milliseconds: 800),
          builder: (context, val, _) => Text(
            '$val',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 28,
              letterSpacing: 1.1,
              shadows: [
                Shadow(
                  color: Colors.cyanAccent.withOpacity(0.18),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.cyanAccent.withOpacity(0.8),
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
            fontSize: 16,
            letterSpacing: 1.1,
            shadows: [
              Shadow(
                color: Colors.cyanAccent.withOpacity(0.18),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
