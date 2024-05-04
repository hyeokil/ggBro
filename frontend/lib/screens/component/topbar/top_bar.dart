import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/component/topbar/setting.dart';
import 'package:frontend/screens/component/topbar/gging_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
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
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (mainProvider.isMenuSelected != 'profile') {
                context.push('/profile');
              }
              selectedMenu('profile');
            },
            child: ProfileImage(image: Image.asset(AppIcons.earth_1),),
          ),
          GgingBar(),
          Setting(),
        ],
      ),
    );
  }
}
