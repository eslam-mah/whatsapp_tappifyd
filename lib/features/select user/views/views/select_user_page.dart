import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/services/stream.dart';
import 'package:whatsapp/core/utils/images.dart';
import 'package:whatsapp/core/utils/routers.dart';
import 'package:whatsapp/features/select%20user/data/model/user_model.dart';
import 'package:whatsapp/features/select%20user/data/model/users.dart';
import 'package:whatsapp/features/select%20user/views/widgets/user_selector.dart';

/// SelectUserPage allows the user to choose a user to connect with for the chat.
class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  /// Indicates whether a loading indicator should be shown.
  bool isLoading = false;

  /// Connects the selected user to the Stream chat client.
  ///
  /// This function connects the [user] to the [client] and navigates to the home page.
  ///
  /// Parameters:
  /// - [client]: The Stream chat client to connect the user to.
  /// - [user]: The user model containing user details for connection.
  void _connectUser(StreamChatClient client, UserModel user) async {
    setState(() {
      isLoading = true;
    });
    try {
      /// Connects the user to the Stream chat client.
      await client.connectUser(
        User(
          id: user.id,
          extraData: {userName: user.name, userImage: user.image},
        ),
        client.devToken(user.id).rawValue,
      );

      // Navigate to Home with the current user
      GoRouter.of(context).push(
        Rout.kHome,
        extra: user,
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
    /// The Stream chat client used to connect the user.
    final client = StreamChatCore.of(context).client;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Displays the WhatsApp logo at the top.
              SizedBox(
                width: 120.w,
                child: Image.asset(AppImages.whatsAppLogo),
              ),

              /// Text instructing the user to select a user.
              Text(
                'Select a User',
                style: TextStyle(color: Colors.green, fontSize: 28.sp),
              ),
              SizedBox(height: 70.h),

              /// Button to select Ahmed as the user.
              GestureDetector(
                onTap: () {
                  _connectUser(client, ahmed);
                },
                child: const UserSelector(
                  image: AppImages.ahmedImage,
                  name: 'Ahmed',
                ),
              ),
              SizedBox(height: 20.h),

              /// Button to select Mohamed as the user.
              GestureDetector(
                onTap: () {
                  _connectUser(client, mohamed);
                },
                child: const UserSelector(
                  image: AppImages.mohamedImage,
                  name: 'Mohamed',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
