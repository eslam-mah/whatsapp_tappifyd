import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/services/stream.dart';
import 'package:whatsapp/core/utils/images.dart';
import 'package:whatsapp/features/chat/view/widgets/app_bar_back_button.dart';
import 'package:whatsapp/features/chat/view/widgets/message_list.dart';
import 'package:whatsapp/features/chat/view/widgets/message_text_field.dart';
import 'package:whatsapp/features/chat/view/widgets/send_message_button.dart';
import 'package:whatsapp/features/select%20user/data/model/users.dart';

/// ChatPage displays the chat interface for a specific channel.
///
/// This page includes the chat messages, input field, and send button.
class ChatPage extends StatefulWidget {
  /// The chat channel to display messages for.
  final Channel channel;

  const ChatPage({super.key, required this.channel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /// Controller for the message input field.
  final TextEditingController controller = TextEditingController();

  /// Sends a message typed in the input field.
  ///
  /// This function sends a message to the current channel if the input field is not empty.
  Future<void> _sendMessage() async {
    final messageText = controller.text.trim();
    if (messageText.isNotEmpty) {
      final message = Message(
        text: messageText,
        user: context.currentUser!,
        createdAt: DateTime.now(),
      );
      setState(() {
        controller.clear();
      });
      await widget.channel.sendMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// The current user.
    final user = context.currentUser;
    return StreamChannel(
      channel: widget.channel,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              /// A back button that navigates to the previous screen.
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: AppBarBackButton(
                  image: user!.id == ahmed.id ? mohamed.image : ahmed.image,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),

              /// Displays the name of the chat partner.
              Text(
                user.id == ahmed.id ? mohamed.name : ahmed.name,
                style: TextStyle(fontSize: 20.sp),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            /// Background image of the chat screen.
            Image.asset(
              AppImages.backGroundImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),

              /// Displays the list of messages in the chat.
              child: MessageListCore(
                loadingBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                emptyBuilder: (context) =>
                    const Center(child: Text('No messages yet')),
                messageListBuilder: (context, messages) {
                  return MessagesList(messages: messages);
                },
                errorBuilder: (context, error) =>
                    const Center(child: Text('Error loading messages')),
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: Row(
                children: [
                  /// Input field for typing messages.
                  Expanded(
                    child: MessageTextField(controller: controller),
                  ),
                  SizedBox(width: 10.w),

                  /// Button for sending messages.
                  GestureDetector(
                    onTap: _sendMessage,
                    child: const SendMessageButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
