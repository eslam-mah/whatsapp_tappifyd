import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/features/chat/view/views/chat_page.dart';
import 'package:whatsapp/features/home%20page/home_page.dart';
import 'package:whatsapp/features/select%20user/views/views/select_user_page.dart';

abstract class Rout {
  static const kRegister = '/users';
  static const kHome = '/chat';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SelectUserPage(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final channel = state.extra as Channel;
        return ChatPage(channel: channel);
      },
    ),
    GoRoute(
      path: '/initiate-chat',
      builder: (context, state) => const ChatInitiationPage(),
    ),
  ]);
}
