import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/chat/models/message.dart';
import 'package:modern_todo_app/features/chat/services/chat_service.dart';

final chatServiceProvider = Provider((ref) => ChatService());

final chatMessagesProvider = StreamProvider<List<Message>>((ref) {
  final chatService = ref.watch(chatServiceProvider);
  return chatService.getMessages('global');
});
