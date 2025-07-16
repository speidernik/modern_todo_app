import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

enum Priority {
  low,
  medium,
  high,
}

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required String description,
    required DateTime dueDate,
    required Priority priority,
    @Default(false) bool isCompleted,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
