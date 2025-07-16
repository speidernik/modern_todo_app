import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/add_todo_bottom_sheet.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/category_chip.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/todo_list.dart';
import 'package:modern_todo_app/features/home/providers/todo_provider.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _searchController = TextEditingController();
  TodoCategory? _selectedCategory;
  bool _showCompleted = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddTodoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          AddTodoBottomSheet(initialCategory: _selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'tasks')),
        actions: [
          IconButton(
            icon: Icon(
              _showCompleted ? Icons.check_circle : Icons.check_circle_outline,
            ),
            onPressed: () => setState(() => _showCompleted = !_showCompleted),
            tooltip: _showCompleted
                ? TranslationService.tr(context, 'showUncompleted')
                : TranslationService.tr(context, 'showCompleted'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: TranslationService.tr(context, 'searchTasks'),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                // Category filters
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryChip(
                        category: null,
                        isSelected: _selectedCategory == null,
                        onTap: () => setState(() => _selectedCategory = null),
                      ),
                      const SizedBox(width: 8),
                      ...TodoCategory.values.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CategoryChip(
                            category: category,
                            isSelected: _selectedCategory == category,
                            onTap: () =>
                                setState(() => _selectedCategory = category),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: todos.when(
              data: (todos) {
                // Apply filters
                var filteredTodos = todos.where((todo) {
                  // Filter by completion status
                  if (_showCompleted) {
                    return todo.isCompleted;
                  } else {
                    return !todo.isCompleted;
                  }
                }).toList();

                // Filter by category
                if (_selectedCategory != null) {
                  filteredTodos = filteredTodos.where((todo) {
                    return todo.category == _selectedCategory;
                  }).toList();
                }

                // Filter by search query
                final query = _searchController.text.toLowerCase();
                if (query.isNotEmpty) {
                  filteredTodos = filteredTodos.where((todo) {
                    return todo.title.toLowerCase().contains(query) ||
                        todo.description.toLowerCase().contains(query);
                  }).toList();
                }

                return TodoList(todos: filteredTodos);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  '${TranslationService.tr(context, 'error')}${error.toString()}',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTodoSheet,
        label: Text(TranslationService.tr(context, 'addTask')),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
