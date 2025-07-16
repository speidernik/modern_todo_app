import 'package:flutter/material.dart';
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
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                if (value != null) {
                  ref.read(todoProvider.notifier).toggleTodo(todo.id);
                }
              },
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todo.description.isNotEmpty) ...[
                  Text(todo.description),
                  const SizedBox(height: 4),
                ],
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat.yMMMd().add_jm().format(todo.dueDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(context, todo.priority),
                  ],
                ),
              ],
            ),
            trailing: isDesktop
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onTodoTap(todo),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(todoProvider.notifier).deleteTodo(todo.id);
                        },
                      ),
                    ],
                  )
                : PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.edit),
                          title: Text(TranslationService.tr(context, 'edit')),
                          onTap: () => onTodoTap(todo),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.delete),
                          title: Text(TranslationService.tr(context, 'delete')),
                          onTap: () {
                            ref.read(todoProvider.notifier).deleteTodo(todo.id);
                          },
                        ),
                      ),
                    ],
                  ),
            onTap: () => onTodoTap(todo),
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
