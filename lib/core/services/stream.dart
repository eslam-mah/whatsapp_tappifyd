import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// stream access key
const streamKey = 'q79wxs76xj63';

/// fetches user data
extension StreamChatContext on BuildContext {
  /// fetches user image
  String? get currentUserImage => StreamChatCore.of(this).currentUser?.image;

  /// fetches user name
  String? get currentUserName => StreamChatCore.of(this).currentUser!.name;

  /// fetches the current user
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
