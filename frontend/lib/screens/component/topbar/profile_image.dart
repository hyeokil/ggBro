import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 3, color: Colors.white),
          boxShadow: [
            BoxShadow(
                color: AppColors.basicgray.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1
            )
          ]
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
      child: Image.asset(AppIcons.earth_1),
    );
  }
}
