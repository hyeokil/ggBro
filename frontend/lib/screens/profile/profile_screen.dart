import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/models/achievement_model.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/profile/component/achievement_button.dart';
import 'package:frontend/screens/profile/component/profile_clear_monster.dart';
import 'package:frontend/screens/profile/component/profile_pet.dart';
import 'package:frontend/screens/profile/component/rescue_button.dart';
import 'package:frontend/screens/profile/dialog/achievement_dialog.dart';
import 'package:frontend/screens/profile/dialog/change_profile_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MainProvider mainProvider;
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    final allPets = Provider.of<PetModel>(context, listen: true).getAllPet();
    final member = Provider.of<MemberModel>(context, listen: true).getMember();

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
                          child: ProfilePet(
                            profilePetImage: member['profile_pet_id'],
                          ),
                        ),
                        ProfileClearMonster(
                          member: member,
                        ),
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () async {
                              final achievements =
                                  Provider.of<AchievementModel>(context,
                                      listen: false);
                              await achievements.getAchievements(accessToken);
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
                  Container(
                    // color: Colors.black,
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: GridView.count(
                      crossAxisCount: 5,
                      // 한 줄에 4개의 항목 표시
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      // padding: EdgeInsets.only(left: 100),
                      children: List.generate(allPets.length, (index) {
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.08, // 각 항목의 높이 설정
                              width: MediaQuery.of(context).size.height *
                                  0.08, // 각 항목의 너비 설정
                              // color: Colors.blue,
                              child: ProfileImage(
                                image:
                                    Image.network('${allPets[index]['image']}'),
                              ),
                            ),
                            allPets[index]['active'] && allPets[index]['have']
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ChangeProfileImage(
                                            name: allPets[index]['name'],
                                            index: index + 1,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.08, // 각 항목의 높이 설정
                                    width: MediaQuery.of(context).size.height *
                                        0.08, // 각 항목의 너비 설정
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                  )
                          ],
                        );
                      }),
                    ),
                  )
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
