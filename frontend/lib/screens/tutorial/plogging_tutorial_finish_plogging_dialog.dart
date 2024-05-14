import 'package:flutter/material.dart';

class PloggingTutorialFinishPloggingDialog extends StatefulWidget {
  const PloggingTutorialFinishPloggingDialog({super.key});

  @override
  State<PloggingTutorialFinishPloggingDialog> createState() =>
      _PloggingTutorialFinishPloggingDialogState();
}

class _PloggingTutorialFinishPloggingDialogState
    extends State<PloggingTutorialFinishPloggingDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text('플로깅 끝 튜토리얼'),
      ),
    );
  }
}
