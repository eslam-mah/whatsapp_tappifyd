import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'package:whatsapp/features/select%20user/data/model/users.dart';

class ChatInitiationPage extends StatefulWidget {
  const ChatInitiationPage({super.key});

  @override
  State<ChatInitiationPage> createState() => _ChatInitiationPageState();
}

class _ChatInitiationPageState extends State<ChatInitiationPage> {
  bool isLoading = false;

  void disconnectUser(BuildContext context) {
    StreamChatCore.of(context).client.disconnectUser();
  }

  Future<void> connectUsersAndStartChat(StreamChatClient client) async {
    setState(() {
      isLoading = true;
    });
    try {
      // Create a common channel
      final channel =
          client.channel('messaging', id: 'chat_ahmed_mohamed', extraData: {
        'members': [ahmed.id, mohamed.id],
      });
      await channel.watch();

      // Navigate to ChatPage with the channel
      GoRouter.of(context).push(
        '/chat',
        extra: channel,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error connecting users: ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = StreamChatCore.of(context).client;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  disconnectUser(context);
                  GoRouter.of(context).pop();
                },
                icon: Icon(Icons.door_back_door))
          ],
          title: Text('Initiate Chat'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              connectUsersAndStartChat(client);
            },
            child: Text('Start Chat Between Ahmed and Mohamed'),
          ),
        ),
      ),
    );
  }
}
