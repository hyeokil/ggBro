import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Text(
              '로그인페이지',
              style: CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung50),
            ),
            GestureDetector(
              onTap: () {
                context.go('/intro');
              },
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
