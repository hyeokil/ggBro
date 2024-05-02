import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/screens/main/dialog/change_partner_dialog.dart';
import 'package:go_router/go_router.dart';

class Partner extends StatefulWidget {
  const Partner({super.key});

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ChangePartnerDialog();
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.95,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Image.asset(AppIcons.meka_sudal),
      ),
    );
  }
}
