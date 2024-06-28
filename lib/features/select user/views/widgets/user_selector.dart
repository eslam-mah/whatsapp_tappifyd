import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/features/chat/view/widgets/custom_profile_picture.dart';

class UserSelector extends StatelessWidget {
  const UserSelector({
    super.key,
    required this.image,
    required this.name,
  });
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          CustomProfilePicture(radius: 30.r, image: image),
          SizedBox(width: 20.w),
          Text(
            name,
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
