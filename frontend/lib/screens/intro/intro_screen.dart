import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '인트로페이지',
      style: CustomFontStyle.yeonSung,
    );
  }
}
