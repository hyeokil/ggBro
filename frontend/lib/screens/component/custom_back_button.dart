import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.rescueButton,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 3, color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: AppColors.basicgray.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
