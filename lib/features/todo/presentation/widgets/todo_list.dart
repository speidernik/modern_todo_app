import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/todo/models/todo.dart';
import 'package:modern_todo_app/features/todo/providers/todo_provider.dart';
import 'package:intl/intl.dart';

class TodoList extends ConsumerWidget {
  final Function(Todo) onTodoTap;

  const TodoList({
    super.key,
    required this.onTodoTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 600;

    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 64,
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              TranslationService.tr(context, 'noTasks'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 500 + index * 50),
          curve: Curves.easeOutBack,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                todo.isCompleted
                    ? Colors.cyanAccent.withOpacity(0.18)
                    : Colors.white.withOpacity(0.10),
                Colors.blueAccent.withOpacity(0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: todo.isCompleted
                    ? Colors.cyanAccent.withOpacity(0.18)
                    : Colors.black.withOpacity(0.10),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: todo.isCompleted
                  ? Colors.cyanAccent.withOpacity(0.3)
                  : Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: ListTile(
            leading: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: todo.isCompleted
                        ? Colors.cyanAccent.withOpacity(0.7)
                        : Colors.transparent,
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Checkbox(
                value: todo.isCompleted,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(todoProvider.notifier).toggleTodo(todo.id);
                  }
                },
                activeColor: Colors.cyanAccent,
                shape: const CircleBorder(),
                side: BorderSide(
                  color: todo.isCompleted
                      ? Colors.cyanAccent
                      : Colors.white.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: todo.isCompleted
                    ? Colors.cyanAccent.withOpacity(0.8)
                    : Colors.white,
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
                letterSpacing: 1.1,
                fontFamily: 'Montserrat',
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            subtitle: todo.dueDate != null
                ? Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 16, color: Colors.cyanAccent.withOpacity(0.7)),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('MMM d, yyyy').format(todo.dueDate!),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                : null,
            trailing: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: todo.isCompleted
                  ? Icon(Icons.check_circle, color: Colors.cyanAccent, size: 28)
                  : Icon(Icons.radio_button_unchecked,
                      color: Colors.white.withOpacity(0.5), size: 28),
            ),
            onTap: () => onTodoTap(todo),
            hoverColor: Colors.cyanAccent.withOpacity(0.10),
            splashColor: Colors.cyanAccent.withOpacity(0.18),
          ),
        );
      },
    );
  }

  Widget _buildPriorityChip(BuildContext context, Priority priority) {
    Color color;
    switch (priority) {
      case Priority.low:
        color = Colors.green;
        break;
      case Priority.medium:
        color = Colors.orange;
        break;
      case Priority.high:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        TranslationService.tr(context, priority.name),
        style: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
    );
  }
}
