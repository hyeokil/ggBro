import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/intro/intro_angryearth.dart';
import 'package:frontend/screens/intro/intro_animal.dart';
import 'package:frontend/screens/intro/intro_animal_box.dart';
import 'package:frontend/screens/intro/intro_animal_trash.dart';
import 'package:frontend/screens/intro/intro_earth.dart';
import 'package:frontend/screens/intro/intro_earth_spacedevil.dart';
import 'package:frontend/screens/intro/intro_sayearth.dart';
import 'package:frontend/screens/intro/intro_trash.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List introBackground = [
    'assets/images/intro_forest_sized.png',
    'assets/images/intro_forest_sized.png',
    'assets/images/intro_space.PNG',
    'assets/images/intro_space.PNG',
    'assets/images/intro_space.PNG',
    'assets/images/intro_forest_sized.png',
    'assets/images/intro_forest_sized.png',
    'assets/images/intro_space.PNG',
    'assets/images/intro_space.PNG',
  ];
  List introSentence = [
    '평화로운 지구마을에',
    '여러 동물들이 살고 있었어요',
    '어느날',
    '지구침략을 노리는 우주괴물이',
    '지구에 쓰레기 폭탄을 던졌어요',
    '동물들은 쓰레기 더미에 쌓여',
    '상자속에 갇혀버렸어요',
    '화가난 지구는',
    '용사들에게 도움을 요청했어요',
  ];
  int count = 0;

  void goNext() {
    setState(() {
      count++;
    });
    // print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (count < 8) {
                goNext();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(introBackground[count]), // 로컬 이미지 사용
                  fit: BoxFit.cover, // 이미지가 컨테이너 전체를 채우도록 설정
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_sentence.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 1,
              child: Center(
                child: Text(
                  introSentence[count],
                  style: CustomFontStyle.cuteFont,
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: count == 1
                ? IntroAnimal()
                : count == 2
                    ? IntroEarth()
                    : count == 3
                        ? IntroEarthSpacedevil()
                        : count == 4
                            ? IntroTrash()
                            : count == 5
                                ? IntroAnimalTrash()
                                : count == 6
                                    ? IntroAnimalBox()
                                    : count == 7
                                        ? IntroAngryEarth()
                                        : count == 8
                                            ? IntroSayEarth()
                                            : Container(),
          ),
        ],
      ),
    );
  }
}
