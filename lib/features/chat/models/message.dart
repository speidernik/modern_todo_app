import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String senderId,
    required String receiverId,
    required String encryptedContent,
    required DateTime timestamp,
    String? mediaUrl,
    String? mediaType, // e.g. 'image', 'file'
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) {
    final ts = json['timestamp'];
    DateTime? timestamp;
    if (ts is Timestamp) {
      timestamp = ts.toDate();
    } else if (ts is String) {
      timestamp = DateTime.tryParse(ts);
    } else if (ts is DateTime) {
      timestamp = ts;
    }
    return Message(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      encryptedContent: json['encryptedContent'] as String,
      timestamp: timestamp ?? DateTime.now(),
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
    );
  }
}
