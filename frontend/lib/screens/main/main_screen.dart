import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/campaign_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/models/ranking_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/menu.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/main/component/exp_bar.dart';
import 'package:frontend/screens/main/component/nickname_bar.dart';
import 'package:frontend/screens/main/dialog/weekly_quest_dialog.dart';
import 'package:frontend/screens/main/openbox/open_box_dialog.dart';
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
  late Map currentPet;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    petModel = Provider.of<PetModel>(context, listen: false);
    petModel.getAllPets(accessToken);
    petModel.getPetDetail(accessToken, -1).then(
          (value) => setState(() {}),
        );
    currentPet = petModel.getCurrentPet();

    if (currentPet['active'] == false && currentPet['exp'] >= 300) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        petModel.openBox(accessToken, -1);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OpenBoxDialog(image: currentPet['image'],);
          },
        ).then(
          (value) => setState(() {}),
        );
      });
    }
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<PetModel>(context, listen: true).getCurrentPet();

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
              TopBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (!_isButtonDisabled) {
                        setState(() {
                          _isButtonDisabled = true; // 버튼 비활성화
                        });
                        final quests =
                            Provider.of<QuestModel>(context, listen: false);
                        await quests.getQuests(accessToken);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const WeeklyQuestDialog();
                          },
                        ).then(
                          (value) => setState(() {
                            _isButtonDisabled = false;
                          }),
                        );
                      }
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
                    onTap: () async {
                      if (!_isButtonDisabled) {
                        setState(() {
                          _isButtonDisabled = true; // 버튼 비활성화
                        });
                        final ranking =
                            Provider.of<RankingModel>(context, listen: false);
                        await ranking.getRanking(accessToken);
                        context.push('/ranking').then((value) {
                          // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        });
                        selectedMenu('ranking');
                      }
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
                      if (!_isButtonDisabled) {
                        setState(() {
                          _isButtonDisabled = true; // 버튼 비활성화
                        });
                        context.push('/history').then((value) {
                          // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        });
                        selectedMenu('history');
                      }
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
                    onTap: () async {
                      if (!_isButtonDisabled) {
                        setState(() {
                          _isButtonDisabled = true; // 버튼 비활성화
                        });
                        final campaign =
                            Provider.of<CampaignModel>(context, listen: false);
                        await campaign.getCampaigns(accessToken);
                        context.push('/campaign').then((value) {
                          // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        });
                        selectedMenu('campaign');
                      }
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
                image: pet['active'] == false
                    ? Image.asset(
                        AppIcons.intro_box,
                      )
                    : Image.network(
                        pet['image'],
                      ),
                isPet: pet['active'],
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
                      : ExpBar(exp: pet['exp']),
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
