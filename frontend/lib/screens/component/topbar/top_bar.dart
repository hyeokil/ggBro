import 'package:flutter/material.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/component/topbar/setting.dart';
import 'package:frontend/screens/component/topbar/gging_bar.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImage(),
            GgingBar(),
            Setting(),
          ],
        ),
    );
  }
}
