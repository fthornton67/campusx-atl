// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String,
  orderId: json['orderId'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  type: $enumDecode(_$MessageTypeEnumMap, json['type']),
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String?,
  location: (json['location'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  timestamp: DateTime.parse(json['timestamp'] as String),
  isRead: json['isRead'] as bool? ?? false,
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'type': _$MessageTypeEnumMap[instance.type]!,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'location': instance.location,
  'timestamp': instance.timestamp.toIso8601String(),
  'isRead': instance.isRead,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.location: 'location',
  MessageType.system: 'system',
};
