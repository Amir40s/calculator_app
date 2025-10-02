import 'package:get/get.dart';
import 'dart:math';

import '../../config/enum/chat_enum.dart';
import '../../config/model/chat_user.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  // Dummy users: current user + support
  final ChatUser currentUser = ChatUser(
    id: "1",
    email: "user@example.com",
    name: "You",
  );

  final ChatUser supportUser = ChatUser(
    id: "2",
    email: "support@company.com",
    name: "Support",
    isSupport: true,
  );

  @override
  void onInit() {
    super.onInit();
    // Load dummy messages
    messages.addAll([
      ChatMessage(
        id: "m1",
        senderId: supportUser.id,
        receiverId: currentUser.id,
        type: MessageType.text,
        content: "Hello! How can I help you today?",
      ),
      ChatMessage(
        id: "m2",
        senderId: currentUser.id,
        receiverId: supportUser.id,
        type: MessageType.text,
        content: "I need help with my account.",
      ),
    ]);
  }

  // Send text message
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final newMessage = ChatMessage(
      id: Random().nextInt(99999).toString(),
      senderId: currentUser.id,
      receiverId: supportUser.id,
      type: MessageType.text,
      content: text,
    );
    messages.add(newMessage);
  }

  // Send image
  void sendImage(String imageUrl) {
    final newMessage = ChatMessage(
      id: Random().nextInt(99999).toString(),
      senderId: currentUser.id,
      receiverId: supportUser.id,
      type: MessageType.image,
      content: imageUrl,
    );
    messages.add(newMessage);
  }

  // Send voice note
  void sendVoice(String audioUrl) {
    final newMessage = ChatMessage(
      id: Random().nextInt(99999).toString(),
      senderId: currentUser.id,
      receiverId: supportUser.id,
      type: MessageType.voice,
      content: audioUrl,
    );
    messages.add(newMessage);
  }
}
