import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25.r,
      backgroundColor: const Color.fromARGB(255, 9, 163, 14),
      child: Icon(
        Icons.send,
        color: Colors.white,
        size: 26.r,
      ),
    );
  }
}
