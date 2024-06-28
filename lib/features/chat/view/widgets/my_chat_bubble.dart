import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MyChatBubble extends StatelessWidget {
  const MyChatBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
                bottomLeft: Radius.circular(32.r))),
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(20.w),
        child: Text(
          message.text ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
