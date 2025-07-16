import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modern_todo_app/features/home/models/todo.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class Todos extends _$Todos {
  @override
  Stream<List<Todo>> build() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Todo.fromMap(data);
      }).toList();
    });
  }

  Future<void> addTodo(
    String title,
    String description,
    DateTime? dueDate,
    TodoCategory? category,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final todo = Todo(
      id: const Uuid().v4(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      category: category,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .doc(todo.id)
        .set(todo.toMap());
  }

  Future<void> toggleTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .doc(todo.id)
        .update({'isCompleted': !todo.isCompleted});
  }

  Future<void> deleteTodo(String todoId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .doc(todoId)
        .delete();
  }

  Future<void> updateTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .doc(todo.id)
        .update(todo.toMap());
  }
}
