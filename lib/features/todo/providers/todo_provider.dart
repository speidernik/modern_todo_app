import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/todo/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(Todo todo) {
    state = state.map((t) => t.id == todo.id ? todo : t).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }
}
