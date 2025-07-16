import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/add_todo_bottom_sheet.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/settings_drawer.dart';
import 'package:modern_todo_app/features/home/presentation/widgets/todo_list.dart';
import 'package:modern_todo_app/features/home/providers/todo_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      drawer: const SettingsDrawer(),
      body: todos.when(
        data: (todos) => TodoList(todos: todos),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddTodoBottomSheet(),
          );
        },
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
