import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/utils/images.dart';
import 'package:whatsapp/core/services/stream.dart';
import 'package:whatsapp/features/chat/view/widgets/app_bar_back_button.dart';
import 'package:whatsapp/features/chat/view/widgets/friend_chat_bubble.dart';
import 'package:whatsapp/features/chat/view/widgets/message_list.dart';
import 'package:whatsapp/features/chat/view/widgets/message_text_field.dart';
import 'package:whatsapp/features/chat/view/widgets/my_chat_bubble.dart';
import 'package:whatsapp/features/chat/view/widgets/send_message_button.dart';
import 'package:whatsapp/features/select%20user/data/model/user_model.dart';
import 'package:whatsapp/features/select%20user/data/model/users.dart';

class ChatPage extends StatefulWidget {
  final Channel channel;

  const ChatPage({super.key, required this.channel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();

  void disconnectUser(BuildContext context) {
    StreamChatCore.of(context).client.disconnectUser();
  }

  Future<void> sendMessage() async {
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
    final user = context.currentUser;
    return StreamChannel(
      channel: widget.channel,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
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
              Text(
                user.id == ahmed.id ? mohamed.name : ahmed.name,
                style: TextStyle(fontSize: 20.sp),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              AppImages.backGroundImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: MessageListCore(
                loadingBuilder: (context) =>
                    Center(child: CircularProgressIndicator()),
                emptyBuilder: (context) =>
                    Center(child: Text('No messages yet')),
                messageListBuilder: (context, messages) {
                  return MessagesList(messages: messages);
                },
                errorBuilder: (context, error) =>
                    Center(child: Text('Error loading messages')),
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: Row(
                children: [
                  Expanded(
                    child: MessageTextField(controller: controller),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: sendMessage,
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
