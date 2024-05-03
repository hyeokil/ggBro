import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final String? hint, label;
  final bool obscure;
  final Icon? icon;

  const CustomInput({
    super.key,
    required this.controller,
    this.validator,
    this.keyboard,
    this.icon,
    this.hint,
    this.label,
    this.obscure = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          icon: icon,
          hintText: hint,
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: const Color.fromRGBO(225, 235, 200, 1),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              )),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
