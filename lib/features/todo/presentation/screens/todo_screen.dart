import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(TranslationService.tr(context, 'appName')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTodoDialog,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToSettings,
          ),
        ],
      ),
      body: isDesktop
          ? _buildDesktopLayout()
          : isTablet
              ? _buildTabletLayout()
              : _buildMobileLayout(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: _showAddTodoDialog,
              child: const Icon(Icons.add),
            )
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
