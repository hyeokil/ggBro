import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/menu.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/main/component/exp_bar.dart';
import 'package:frontend/screens/main/component/nickname_bar.dart';
import 'package:frontend/screens/main/dialog/weekly_quest_dialog.dart';
import 'package:frontend/screens/main/partner/partner.dart';
import 'package:frontend/screens/ranking/ranking_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainProvider mainProvider;
  late UserProvider userProvider;
  late String accessToken;
  late PetModel petModel;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    petModel = Provider.of<PetModel>(context, listen: false);
    petModel.getPetDetail(accessToken, 1).then(
          (value) => setState(() {}),
        );
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<PetModel>(context, listen: true).getPet();

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
          ),
          child: Column(
            children: [
              const TopBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final quests = Provider.of<QuestModel>(context, listen: false);
                      await quests.getQuests(accessToken);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const WeeklyQuestDialog();
                        },
                      );
                    },
                    child: Menu(
                      color: AppColors.basicpink,
                      shadowColor: AppColors.basicShadowPink,
                      icon: Icon(
                        FontAwesomeIcons.calendarCheck,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      content: '주간 퀘스트',
                    ),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.04,
                  // ),
                  GestureDetector(
                    onTap: () {
                      context.push('/ranking');
                      selectedMenu('ranking');
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation, secondaryAnimation) =>
                      //         RankingScreen(),
                      //     transitionsBuilder:
                      //         (context, animation, secondaryAnimation, child) {
                      //       var begin = Offset(1.0, 0.0);
                      //       var end = Offset.zero;
                      //       var curve = Curves.ease;
                      //
                      //       var tween = Tween(begin: begin, end: end)
                      //           .chain(CurveTween(curve: curve));
                      //
                      //       return SlideTransition(
                      //         position: animation.drive(tween),
                      //         child: child,
                      //       );
                      //     },
                      //   ),
                      // );
                      // selectedMenu('ranking');
                    },
                    child: Menu(
                      color: AppColors.basicgray,
                      shadowColor: AppColors.basicShadowGray,
                      icon: Icon(
                        FontAwesomeIcons.trophy,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      content: '랭킹',
                    ),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.04,
                  // ),
                  GestureDetector(
                    onTap: () {
                      context.push('/history');
                      selectedMenu('history');
                    },
                    child: Menu(
                      color: AppColors.basicgreen,
                      shadowColor: AppColors.basicShadowGreen,
                      icon: Icon(
                        FontAwesomeIcons.clipboardList,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      content: '히스토리',
                    ),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.04,
                  // ),
                  GestureDetector(
                    onTap: () {
                      context.push('/campaign');
                      selectedMenu('campaign');
                    },
                    child: Menu(
                      color: AppColors.basicnavy,
                      shadowColor: AppColors.basicShadowNavy,
                      icon: Icon(
                        FontAwesomeIcons.users,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      content: '캠페인',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Partner(
                image: pet['image'] == null
                    ? Image.asset(AppIcons.intersect)
                    : Image.network(
                        pet['image'],
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  pet['active']
                      ? NickNameBar(
                          nickName: pet['nickname'],
                        )
                      : ExpBar(),
                  GestureDetector(
                    onTap: () {
                      context.push('/ploggingReady');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.readyButton,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.basicgray.withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.003,
                            left: MediaQuery.of(context).size.width * 0.015,
                            child: Container(
                              child: const Icon(
                                Icons.directions_run_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '   준비하기',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung80_white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ClearMonster(pet: pet),
            ],
          ),
        ),
      ),
    );
  }
}
