import 'package:flutter/material.dart';
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
        context.push('/bluetooth');
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.32,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
