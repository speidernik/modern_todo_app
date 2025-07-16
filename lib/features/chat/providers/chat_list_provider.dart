import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/features/chat/models/message.dart';

class ChatSummary {
  final String chatId;
  final List<String> participants;
  final Message? lastMessage;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatar;

  ChatSummary({
    required this.chatId,
    required this.participants,
    this.lastMessage,
    this.isGroup = false,
    this.groupName,
    this.groupAvatar,
  });
}

final chatListProvider = FutureProvider.family<List<ChatSummary>, String>(
    (ref, currentUserId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('chats')
      .where('participants', arrayContains: currentUserId)
      .get();
  return snapshot.docs.map((doc) {
    final data = doc.data();
    final lastMsg = data['lastMessage'] != null
        ? Message.fromJson(Map<String, dynamic>.from(data['lastMessage']))
        : null;
    return ChatSummary(
      chatId: doc.id,
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: lastMsg,
      isGroup: data['isGroup'] ?? false,
      groupName: data['groupName'],
      groupAvatar: data['groupAvatar'],
    );
  }).toList();
});
