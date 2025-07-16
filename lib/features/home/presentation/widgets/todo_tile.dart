import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/home/models/todo.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/edit_todo_dialog.dart';
import 'package:modern_todo_app/features/home/providers/todo_provider.dart';

class TodoTile extends ConsumerWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditTodoDialog(todo: todo),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final doneColor = isDark ? Colors.green.shade900 : Colors.green.shade700;
    final completedTextColor =
        isDark ? Colors.green.shade300 : Colors.green.shade700;

    return Slidable(
      key: ValueKey(todo.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(TranslationService.tr(context, 'deleteTask')),
                  content: Text(
                    TranslationService.tr(context, 'deleteTaskConfirmation'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(TranslationService.tr(context, 'cancel')),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref.read(todosProvider.notifier).deleteTodo(todo.id);
                        Navigator.pop(context);
                      },
                      child: Text(TranslationService.tr(context, 'delete')),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            icon: Icons.delete_outline,
            label: TranslationService.tr(context, 'delete'),
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(12),
            ),
            padding: EdgeInsets.zero,
            autoClose: true,
            flex: 1,
            spacing: 0,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) {
              ref.read(todosProvider.notifier).toggleTodo(todo);
            },
            backgroundColor: doneColor,
            foregroundColor: Colors.white,
            icon: todo.isCompleted ? Icons.undo : Icons.check,
            label: todo.isCompleted
                ? TranslationService.tr(context, 'markUndone')
                : TranslationService.tr(context, 'markDone'),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            padding: EdgeInsets.zero,
            autoClose: true,
            flex: 1,
            spacing: 0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          _showEditDialog(context);
        },
        child: AnimatedScale(
          scale: 1.0,
          duration: 200.ms,
          curve: Curves.easeInOut,
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: todo.isCompleted ? 0 : 2,
            color: todo.isCompleted ? doneColor.withValues(alpha: 0.1) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: todo.isCompleted
                  ? BorderSide(color: doneColor.withValues(alpha: 0.2))
                  : BorderSide.none,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  todo.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: todo.isCompleted
                                        ? completedTextColor
                                        : null,
                                  ),
                                ),
                              ),
                              if (todo.category != null) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  todo.category!.icon,
                                  size: 16,
                                  color: todo.isCompleted
                                      ? completedTextColor
                                      : todo.category!.color,
                                ),
                              ],
                            ],
                          ),
                          if (todo.description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              todo.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: todo.isCompleted
                                    ? completedTextColor
                                    : theme.colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ],
                          if (todo.dueDate != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: todo.isCompleted
                                      ? completedTextColor
                                      : theme.colorScheme.primary
                                          .withValues(alpha: 0.7),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${TranslationService.tr(context, 'dueDate')}: ${DateFormat('MMM d, y').format(todo.dueDate!)}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: todo.isCompleted
                                        ? completedTextColor
                                        : theme.colorScheme.primary
                                            .withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (!todo.isCompleted)
                      Icon(
                        Icons.chevron_right,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.2, end: 0)
        .then()
        .shimmer(
            duration: 1200.ms,
            color: theme.colorScheme.primary.withValues(alpha: 0.1));
  }
}
