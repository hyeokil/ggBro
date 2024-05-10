import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/screens/plogging/progressplogging/progress_plogging.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScanDeviceTile extends StatefulWidget {
  final BluetoothDevice device;
  final Function func;
  const ScanDeviceTile({
    super.key,
    required this.device,
    required this.func,
  });

  @override
  State<ScanDeviceTile> createState() => _ScanDeviceTileState();
}

class _ScanDeviceTileState extends State<ScanDeviceTile> {
  final int maxRetries = 10; // 최대 재시도 횟수
  int retryCount = 0; // 현재 재시도 횟수
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            connectToDevice(widget.device);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: AppColors.basicgray,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                    color: AppColors.basicgray.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.device.advName.length > 15
                      ? '${widget.device.advName.substring(0, 15)}...'
                      : widget.device.advName,
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung60_white),
                ),
                Text(
                  isConnected ? '연결중.....' : '',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung60_white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  connectToDevice(BluetoothDevice device) async {
    if (device.isConnected) {
      return;
    }
    setState(() {
      isConnected = true;
      retryCount += 1;
    });
    if (retryCount == maxRetries) {
      retryCount = 0;
      isConnected = false;
      Fluttertoast.showToast(msg: '연결에 실패했습니다. 다시 한번 시도 해주세요');
    }
    try {
      await device.connect();
    } catch (e) {
      connectToDevice(device);
    }
    if (device.isConnected && mounted) {
      Fluttertoast.showToast(msg: '${device.advName} 연결됨');
      var main = Provider.of<MainProvider>(context, listen: false);
      main.setDevice(device);
      print('현재 루트 ${Navigator.of(context).widget.initialRoute}');
      Navigator.of(context).pop(); // 대화상자 닫기
      widget.func();
      // context.go('/ploggingProgress');
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => const ProgressPlogging(),
      // ));
    }
  }
}
