import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';

class ExpBar extends StatefulWidget {
  const ExpBar({super.key});

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: AppColors.basicgray.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.013,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.025,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.013,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.025,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
