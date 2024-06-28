import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whatsapp/features/chat/view/widgets/custom_profile_picture.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.arrow_back,
          size: 30.r,
        ),
        SizedBox(
          width: 8.w,
        ),
        CustomProfilePicture(
          radius: 17.r,
          image: image,
        ),
      ],
    );
  }
}
