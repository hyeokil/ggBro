import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frontend/screens/plogging/progressplogging/component/progress_map.dart';

class ProgressPlogging extends StatelessWidget {
  final BluetoothDevice device;
  const ProgressPlogging({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: background(),
        child: Stack(
          children: [
            ProgressMap(device: device),
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
