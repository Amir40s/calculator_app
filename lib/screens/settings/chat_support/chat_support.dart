import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';

import '../../../core/component/chat_bubble.dart';
import '../../../core/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final  controller = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(text: 'Support Chat',showDivider: true,),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = msg.senderId == controller.currentUser.id;
                  return ChatBubble(message: msg, isMe: isMe);
                },
              );
            }),
          ),

          // Input Area
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // Dummy image
                    controller.sendImage(
                        "https://placekitten.com/200/200");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Dummy voice note
                    controller.sendVoice(
                        "https://example.com/audio/sample.mp3");
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    controller.sendMessage(textController.text);
                    textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
