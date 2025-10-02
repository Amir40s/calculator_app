import '../enum/chat_enum.dart';

class ChatUser {
  final String id;
  final String email;
  final String name;
  final bool isSupport;

  ChatUser({
    required this.id,
    required this.email,
    required this.name,
    this.isSupport = false,
  });
}class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final MessageType type;
  final String content; // text or URL (image/audio)

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
  });
}