import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/features/chat/models/chat_user.dart';

final userListProvider =
    FutureProvider.family<List<ChatUser>, String>((ref, currentUserId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isNotEqualTo: currentUserId)
      .get();
  return snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
});
