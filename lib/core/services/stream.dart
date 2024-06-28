import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// stream access key
const streamKey = 'q79wxs76xj63';

/// messaging channel
const messagingChannel = 'messaging';

/// members
const members = 'members';

/// ahmed and mohamed chat id
const ahmedMohamedChatId = 'chat_ahmed_mohamed';

/// user name
const userName = 'name';

/// user image
const userImage = 'image';

/// fetches user data
extension StreamChatContext on BuildContext {
  /// fetches user image
  String? get currentUserImage => StreamChatCore.of(this).currentUser?.image;

  /// fetches user name
  String? get currentUserName => StreamChatCore.of(this).currentUser!.name;

  /// fetches the current user
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
