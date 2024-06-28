import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/utils/images.dart';
import 'package:whatsapp/core/utils/routers.dart';
import 'package:whatsapp/features/select%20user/data/model/user_model.dart';
import 'package:whatsapp/features/select%20user/data/model/users.dart';
import 'package:whatsapp/features/select%20user/views/widgets/user_selector.dart';

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  bool isLoading = false;

  void connectUser(StreamChatClient client, UserModel user) async {
    setState(() {
      isLoading = true;
    });
    try {
      await client.connectUser(
          User(
              id: user.id, extraData: {'name': user.name, 'image': user.image}),
          client.devToken(user.id).rawValue);

      // Navigate to ChatInitiationPage with the current user
      GoRouter.of(context).push(
        Rout.kHome,
        extra: user,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(
          '------------------------${e.toString()}----------------------------');
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120.w,
                child: Image.asset(AppImages.whatsAppLogo),
              ),
              Text(
                'Select a User',
                style: TextStyle(color: Colors.green, fontSize: 28.sp),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {
                  connectUser(client, ahmed);
                },
                child: UserSelector(
                  image: AppImages.ahmedImage,
                  name: 'Ahmed',
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  connectUser(client, mohamed);
                },
                child: UserSelector(
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
