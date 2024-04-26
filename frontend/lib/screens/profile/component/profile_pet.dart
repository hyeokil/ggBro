import 'package:flutter/material.dart';

class ProfilePet extends StatefulWidget {
  const ProfilePet({super.key});

  @override
  State<ProfilePet> createState() => _ProfilePetState();
}

class _ProfilePetState extends State<ProfilePet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
