import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import '../../config/enum/chat_enum.dart';
import '../../config/model/chat_user.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;

    switch (message.type) {
      case MessageType.text:
        contentWidget = AppTextWidget(text:
          message.content,
          textStyle: TextStyle(color: isMe ? Colors.white : Colors.black),
        );
        break;
      case MessageType.image:
        contentWidget = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            message.content,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
        break;
      case MessageType.voice:
        contentWidget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow, color: isMe ? Colors.white : Colors.black),
             AppTextWidget(text: "Voice Note"),
          ],
        );
        break;
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.premiumColor : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            bottomLeft: isMe ? Radius.circular(14.px) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) :Radius.circular(14.px),
            topLeft: Radius.circular(14.px),
            topRight: Radius.circular(14.px),
          )
        ),
        child: contentWidget,
      ),
    );
  }
}
