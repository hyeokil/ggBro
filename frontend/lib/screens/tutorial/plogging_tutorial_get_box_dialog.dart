import 'package:flutter/material.dart';

class PloggingTutorialGetBoxDialog extends StatefulWidget {
  const PloggingTutorialGetBoxDialog({super.key});

  @override
  State<PloggingTutorialGetBoxDialog> createState() => _PloggingTutorialGetBoxDialogState();
}

class _PloggingTutorialGetBoxDialogState extends State<PloggingTutorialGetBoxDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text('박스 획득이요'),
      ),
    );
  }
}
