import 'package:flutter/material.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_box_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_finish_plogging_dialog.dart';
import 'package:frontend/screens/tutorial/plogging_tutorial_get_box_dialog.dart';

class PloggingTutorialKillTrashDialog extends StatefulWidget {
  const PloggingTutorialKillTrashDialog({super.key});

  @override
  State<PloggingTutorialKillTrashDialog> createState() =>
      _PloggingTutorialKillTrashDialogState();
}

class _PloggingTutorialKillTrashDialogState
    extends State<PloggingTutorialKillTrashDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PloggingTutorialBoxDialog();
          },
        ).then((value) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PloggingTutorialGetBoxDialog();
            },
          ).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PloggingTutorialFinishPloggingDialog();
              },
            );
          });
        });
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Text('플라스틱 처치했어!'),
      ),
    );
  }
}
