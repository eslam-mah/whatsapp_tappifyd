import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/core/utils/routers.dart';
import 'package:whatsapp/core/services/stream.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp(WhatsApp(
    client: client,
  ));
}

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key, required this.client});
  final StreamChatClient client;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return StreamChatCore(
            client: client,
            child: MaterialApp.router(
              theme: ThemeData.light(),
              routerConfig: Rout.router,
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
