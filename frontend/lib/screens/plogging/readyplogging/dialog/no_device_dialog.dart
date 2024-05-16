import 'package:flutter/material.dart';

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
          const Text(
            '기기 없을 시 기본적인 플로깅만 가능합니다.',
            style: TextStyle(fontSize: 15),
          ),
          const Text(
            '쓰레기통 위치 확인, 실시간 경로 기능만 가능, 플로깅 기록 남지 X',
            style: TextStyle(fontSize: 15),
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
