import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                const CustomInput(
                  icon: Icon(Icons.mail),
                  hint: "Email",
                  label: "이메일",
                ),
                const CustomInput(
                  icon: Icon(Icons.lock),
                  hint: "PW",
                  label: "비밀번호",
                  obscure: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.go('/intro');
                      },
                      style: const ButtonStyle(),
                      child: const Text("로그인"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/signUp');
                      },
                      child: const Text("회원가입"),
                    )
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  final String? hint, label;
  final bool obscure;
  final Icon? icon;

  const CustomInput(
      {super.key, this.icon, this.hint, this.label, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: obscure,
        keyboardType: TextInputType.emailAddress,
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
