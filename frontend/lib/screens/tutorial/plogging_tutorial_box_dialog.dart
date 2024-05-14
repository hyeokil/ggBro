import 'package:flutter/material.dart';

class PloggingTutorialBoxDialog extends StatefulWidget {
  const PloggingTutorialBoxDialog({super.key});

  @override
  State<PloggingTutorialBoxDialog> createState() => _PloggingTutorialBoxDialogState();
}

class _PloggingTutorialBoxDialogState extends State<PloggingTutorialBoxDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text('박스 사랴랑!'),
      ),
    );
  }
}
