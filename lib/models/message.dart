import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

enum MessageType { text, image, location, system }

@JsonSerializable()
class Message {
  final String id;
  final String orderId;
  final String senderId;
  final String receiverId;
  final MessageType type;
  final String content;
  final String? imageUrl;
  final Map<String, double>? location; // lat, lng
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.orderId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    this.imageUrl,
    this.location,
    required this.timestamp,
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
