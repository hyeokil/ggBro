import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/profile/component/achievement_button.dart';
import 'package:frontend/screens/profile/component/profile_clear_monster.dart';
import 'package:frontend/screens/profile/component/profile_pet.dart';
import 'package:frontend/screens/profile/component/rescue_button.dart';
import 'package:frontend/screens/profile/dialog/achievement_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MainProvider mainProvider;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 그라데이션 시작 위치
              end: Alignment.bottomCenter, // 그라데이션 끝 위치
              colors: [
                Color.fromRGBO(203, 242, 245, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(254, 206, 224, 1),
              ], // 그라데이션 색상 배열
            ),
          ), // 전
          child: Stack(
            children: [
              Column(
                children: [
                  TopBar(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 1.25,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ProfilePet(),
                        ),
                        ProfileClearMonster(),
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AchievementDialog();
                                },
                              );
                            },
                            child: AchievementButton(),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.26,
                          child: GestureDetector(
                            onTap: () {
                              context.push('/rescue');
                              selectedMenu('rescue');
                            },
                            child: RescueButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ProfileImage(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ProfileImage(),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
