import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/features/chat/models/message.dart';
import 'package:modern_todo_app/features/chat/services/encryption_service.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Message>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId, // ignored for global
    required String plainText,
  }) async {
    final encryptedContent = EncryptionService.encryptText(plainText);
    final message = Message(
      id: _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc()
          .id,
      senderId: senderId,
      receiverId: '',
      encryptedContent: encryptedContent,
      timestamp: DateTime.now().toUtc(),
    );
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(message.id)
        .set(message.toJson());
    // No participants/lastMessage/FCM logic for global chat
  }

  Future<void> sendMediaMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String plainText,
    required String mediaUrl,
    required String mediaType, // e.g. 'image', 'file'
  }) async {
    final encryptedContent = EncryptionService.encryptText(plainText);
    final message = Message(
      id: _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc()
          .id,
      senderId: senderId,
      receiverId: receiverId,
      encryptedContent: encryptedContent,
      timestamp: DateTime.now().toUtc(),
      mediaUrl: mediaUrl,
      mediaType: mediaType,
    );
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(message.id)
        .set(message.toJson());
    // Update chat document with last message and participants
    await _firestore.collection('chats').doc(chatId).set({
      'participants': [senderId, receiverId],
      'lastMessage': message.toJson(),
    }, SetOptions(merge: true));
  }
}
