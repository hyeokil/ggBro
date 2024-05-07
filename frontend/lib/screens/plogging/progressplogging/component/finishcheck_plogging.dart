import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/plogging/finishplogging/finish_plogging_dialog.dart';
import 'package:go_router/go_router.dart';

class FinishCheckPloggingDialog extends StatefulWidget {
  final Function onConfirm;

  const FinishCheckPloggingDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<FinishCheckPloggingDialog> createState() =>
      _FinishCheckPloggingDialogState();
}

class _FinishCheckPloggingDialogState extends State<FinishCheckPloggingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Row(
        children: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onConfirm();
              },
              child: const Text('확인'))
        ],
      ),
    );
  }
}
