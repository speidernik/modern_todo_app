import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/home/models/todo.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/todo_tile.dart';

class TodoList extends ConsumerWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Group todos by category
    final Map<TodoCategory?, List<Todo>> groupedTodos = {};

    // Initialize groups for all categories
    groupedTodos[null] = []; // For uncategorized todos
    for (final category in TodoCategory.values) {
      groupedTodos[category] = [];
    }

    // Sort todos into categories
    for (final todo in todos) {
      groupedTodos[todo.category]?.add(todo);
    }

    // Create list of sections
    final sections = <Widget>[];

    // Add uncategorized todos first if any exist
    if (groupedTodos[null]!.isNotEmpty) {
      sections.add(
        _CategorySection(category: null, todos: groupedTodos[null]!),
      );
    }

    // Add categorized todos
    for (final category in TodoCategory.values) {
      if (groupedTodos[category]!.isNotEmpty) {
        sections.add(
          _CategorySection(category: category, todos: groupedTodos[category]!),
        );
      }
    }

    if (sections.isEmpty) {
      return const Center(child: Text('No tasks found'));
    }

    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (context, index) => sections[index],
    );
  }
}

class _CategorySection extends StatelessWidget {
  final TodoCategory? category;
  final List<Todo> todos;

  const _CategorySection({required this.category, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              if (category != null) ...[
                Icon(category!.icon, color: category!.color, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                category != null
                    ? TranslationService.tr(context, category!.name)
                    : TranslationService.tr(context, 'uncategorized'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: category?.color ??
                          Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      (category?.color ?? Theme.of(context).colorScheme.primary)
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  todos.length.toString(),
                  style: TextStyle(
                    color: category?.color ??
                        Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoTile(todo: todos[index]),
        ),
      ],
    );
  }
}
