import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_content.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_title.dart';
import 'package:frontend/screens/profile/component/Profile_clear_monster_content.dart';
import 'package:frontend/screens/profile/component/profile_clear_monster_title.dart';

class ProfileClearMonster extends StatefulWidget {
  const ProfileClearMonster({super.key});

  @override
  State<ProfileClearMonster> createState() => _ClearMonsterState();
}

class _ClearMonsterState extends State<ProfileClearMonster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.53,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: AppColors.basicgray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileClearMonsterTitle(),
          ProfileClearMonsterContent(color: AppColors.basicpink, content: '플라몽',),
          ProfileClearMonsterContent(color: AppColors.basicgray, content: '포 캔몽',),
          ProfileClearMonsterContent(color: AppColors.basicgreen, content: '율몽',),
          ProfileClearMonsterContent(color: AppColors.basicnavy, content: '미쪼몬',),
        ],
      ),
    );
  }
}
