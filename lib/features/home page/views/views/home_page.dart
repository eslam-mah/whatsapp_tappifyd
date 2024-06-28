import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/services/stream.dart';
import 'package:whatsapp/core/utils/routers.dart';
import 'package:whatsapp/features/select%20user/data/model/users.dart';
import 'package:whatsapp/features/select%20user/views/widgets/user_selector.dart';

/// HomePage displays the main screen where users can initiate a chat.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Indicates whether a loading indicator should be shown.
  bool isLoading = false;

  /// Disconnects the current user from the Stream chat.
  ///
  /// Parameters:
  /// - [context]: The build context of the widget.
  void disconnectUser(BuildContext context) {
    StreamChatCore.of(context).client.disconnectUser();
  }

  /// Connects users and starts a chat channel between Ahmed and Mohamed.
  ///
  /// This function creates a chat channel between Ahmed and Mohamed and navigates to the chat page.
  ///
  /// Parameters:
  /// - [client]: The Stream chat client to connect the users to.
  Future<void> _connectUsersAndStartChat(StreamChatClient client) async {
    setState(() {
      isLoading = true;
    });
    try {
      // Create a common channel
      final channel =
          client.channel(messagingChannel, id: ahmedMohamedChatId, extraData: {
        members: [ahmed.id, mohamed.id],
      });
      await channel.watch();

      // Navigate to ChatPage with the channel
      GoRouter.of(context).push(
        Rout.kChat,
        extra: channel,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// The current user.
    final user = context.currentUser;

    /// The Stream chat client used to connect the user.
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
              icon: const Icon(Icons.logout, color: Colors.red),
            ),
          ],
          title: Text(
            'WhatsApp',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.5.h),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              height: 0.5.h,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),

            /// Button to initiate chat between Ahmed and Mohamed.
            InkWell(
              onTap: () {
                _connectUsersAndStartChat(client);
              },
              child: UserSelector(
                image: user!.id == ahmed.id ? mohamed.image : ahmed.image,
                name: user.id == ahmed.id ? mohamed.name : ahmed.name,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
