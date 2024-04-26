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
                const EmailInput(),
                const NickNameInput(),
                const PasswordInput(),
                const PasswordCheckInput(),
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

class NickNameInput extends StatelessWidget {
  const NickNameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            hintText: "nickname",
            labelText: "닉네임",
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )),
      ),
    );
  }
}

class PasswordCheckInput extends StatelessWidget {
  const PasswordCheckInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            icon: Icon(Icons.check),
            hintText: "Password check",
            labelText: "비밀번호 확인",
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )),
      ),
    );
  }
}
