import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/core/encryption/encryption_service.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TodoCategory? category;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    this.dueDate,
    this.category,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TodoCategory? category,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': EncryptionService.encryptData(title),
      'description': EncryptionService.encryptData(description),
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'category': category?.name,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: EncryptionService.decryptData(map['title'] as String),
      description: EncryptionService.decryptData(map['description'] as String),
      isCompleted: map['isCompleted'] as bool,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      dueDate: map['dueDate'] != null
          ? (map['dueDate'] as Timestamp).toDate()
          : null,
      category: map['category'] != null
          ? TodoCategory.values.firstWhere(
              (e) => e.name == map['category'],
              orElse: () => TodoCategory.personal,
            )
          : null,
    );
  }
}
