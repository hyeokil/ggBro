import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/screens/tutorial/go_plogginG_tutorial_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<Setting> {
  late MainProvider mainProvider;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GoPloggingTutorialDialog();
          },
        ).then(
              (value) {
            setState(() {});
            context.push('/ploggingReady');
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.basicpink,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 3, color: Colors.white),
          boxShadow: [
            BoxShadow(
                color: AppColors.basicgray.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1)
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.height * 0.08,
        child: Icon(
          // mainProvider.isMenuSelected == 'main'
          //     ? Icons.settings : Icons.home_filled,
          Icons.settings,
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.12,
        ),
      ),
    );
  }
}
