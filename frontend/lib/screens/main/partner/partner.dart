import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/main/dialog/change_partner_dialog.dart';
import 'package:frontend/screens/main/openbox/open_box_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Partner extends StatefulWidget {
  final Image image;

  const Partner({
    super.key,
    required this.image,
  });

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pet = Provider.of<PetModel>(context, listen: false);
        await pet.getPets(accessToken);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ChangePartnerDialog();
          },
        );
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return const OpenBoxDialog();
        //   },
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.95,
        height: MediaQuery.of(context).size.height * 0.32,
        child: widget.image,
      ),
    );
  }
}
