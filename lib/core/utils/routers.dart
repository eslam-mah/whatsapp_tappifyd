import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:whatsapp/features/chat/view/views/chat_page.dart';
import 'package:whatsapp/features/home%20page/views/home_page.dart';
import 'package:whatsapp/features/select%20user/views/views/select_user_page.dart';

/// Abstract class containing route constants and the router configuration
abstract class Rout {
  /// Route path for the chat page
  static const kChat = '/chat';

  /// Route path for the home page
  static const kHome = '/Home';

  /// The router configuration for the application
  static final router = GoRouter(
    routes: [
      // Route for the select user page
      GoRoute(
        path: '/',
        builder: (context, state) => const SelectUserPage(),
      ),
      // Route for the chat page, expects a Channel object in state.extra
      GoRoute(
        path: kChat,
        builder: (context, state) {
          // Extract the Channel object passed as an extra
          final channel = state.extra as Channel;
          return ChatPage(channel: channel);
        },
      ),
      // Route for the home page
      GoRoute(
        path: kHome,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
