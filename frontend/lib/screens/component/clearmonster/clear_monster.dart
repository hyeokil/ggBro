import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_content.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster_title.dart';

class ClearMonster extends StatefulWidget {
  const ClearMonster({super.key});

  @override
  State<ClearMonster> createState() => _ClearMonsterState();
}

class _ClearMonsterState extends State<ClearMonster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClearMonsterTitle(),
          ClearMonsterContent(color: AppColors.basicpink, content: '플라몽',),
          ClearMonsterContent(color: AppColors.basicgray, content: '포 캔몽',),
          ClearMonsterContent(color: AppColors.basicgreen, content: '율몽',),
          ClearMonsterContent(color: AppColors.basicnavy, content: '미쪼몬',),
        ],
      ),
    );
  }
}
