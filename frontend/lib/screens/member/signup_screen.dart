import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomInput(
                  icon: Icon(Icons.mail),
                  hint: "Email",
                  label: "이메일",
                ),
                const CustomInput(
                  icon: Icon(Icons.person),
                  hint: "Nickname",
                  label: "닉네임",
                ),
                const CustomInput(
                  icon: Icon(Icons.lock),
                  hint: "Password",
                  label: "비밀번호",
                  obscure: true,
                ),
                const CustomInput(
                  icon: Icon(Icons.check),
                  hint: "Password Check",
                  label: "비밀번호 확인",
                  obscure: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text("뒤로가기")),
                    ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "회원가입 성공",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 20.0);
                        },
                        child: const Text("회원가입"))
                  ],
                )
              ],
            )));
  }
}
