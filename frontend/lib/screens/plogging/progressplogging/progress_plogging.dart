import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/plogging/progressplogging/component/progress_map.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_box_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_finish_plogging_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_box_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_trash_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_kill_trash_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_lacation_dialog.dart';
import 'package:provider/provider.dart';

class ProgressPlogging extends StatefulWidget {
  // final BluetoothDevice device;
  const ProgressPlogging({
    super.key,
    // required this.device,
  });

  @override
  State<ProgressPlogging> createState() => _ProgressPloggingState();
}

class _ProgressPloggingState extends State<ProgressPlogging> {
  late UserProvider userProvider;
  late bool memberTutorial;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    memberTutorial = userProvider.getMemberTutorial();

    if (memberTutorial == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PloggingTutorialLocationDialog();
          },
        ).then(
          (value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PloggingTutorialGetTrashDialog();
              },
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: background(),
        child: const Stack(
          children: [
            ProgressMap(),
          ],
        ),
      ),
    ));
  }

  BoxDecoration background() {
    return const BoxDecoration(
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
    );
  }
}
