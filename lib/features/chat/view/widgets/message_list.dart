import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/services/stream.dart';
import 'package:whatsapp/features/chat/view/widgets/friend_chat_bubble.dart';
import 'package:whatsapp/features/chat/view/widgets/my_chat_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message.user?.id == context.currentUser?.id) {
            return MyChatBubble(message: message);
          } else {
            return FriendChatBubble(message: message);
          }
        },
      ),
    );
  }
}
