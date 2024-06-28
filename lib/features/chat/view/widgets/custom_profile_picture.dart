import 'package:flutter/material.dart';

class CustomProfilePicture extends StatelessWidget {
  const CustomProfilePicture({
    super.key,
    required this.radius,
    required this.image,
  });
  final double radius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
