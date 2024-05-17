import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class NoDeviceDialog extends StatelessWidget {
  final Function onConfirm;
  const NoDeviceDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '기기 없을 시 기본적인 플로깅만 가능합니다.',
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          ),
          Text(
            '쓰레기통 위치 확인,',
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          ),
          Text(
            '실시간 경로 기능만 제공 하고,',
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          ),
        Text(
          '플로깅 기록은 남지 않습니다.',
          style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  child: const Text('확인'))
            ],
          ),
        ],
      ),
    );
  }
}
