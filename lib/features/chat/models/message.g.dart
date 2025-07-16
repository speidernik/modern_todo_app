// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) {
  final ts = json['timestamp'];
  DateTime? timestamp;
  if (ts is Timestamp) {
    timestamp = ts.toDate();
  } else if (ts is String) {
    timestamp = DateTime.tryParse(ts);
  } else if (ts is DateTime) {
    timestamp = ts;
  }
  return _$MessageImpl(
    id: json['id'] as String,
    senderId: json['senderId'] as String,
    receiverId: json['receiverId'] as String,
    encryptedContent: json['encryptedContent'] as String,
    timestamp: timestamp ?? DateTime.now(),
    mediaUrl: json['mediaUrl'] as String?,
    mediaType: json['mediaType'] as String?,
  );
}

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'encryptedContent': instance.encryptedContent,
      'timestamp': instance.timestamp.toIso8601String(),
      'mediaUrl': instance.mediaUrl,
      'mediaType': instance.mediaType,
    };
