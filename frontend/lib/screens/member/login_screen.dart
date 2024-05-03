import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/screens/member/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? _validatePassword(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$',
      caseSensitive: true,
      multiLine: false,
    );
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (!passwordRegex.hasMatch(value)) {
      return '문자, 숫자, 특수 문자가 포함된 8 ~ 15자를 입력해주세요.';
    }
    return null;
  }

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
                EmailField(controller: _email),
                PasswordField(
                  controller: _password,
                  validator: _validatePassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // final auth =
                        //     Provider.of<AuthModel>(context, listen: false);
                        // if (_formKey.currentState!.validate()) {
                        //   // 유효성 검사를 통과한 경우 로그인 로직을 실행합니다.
                        //   String email = _email.text;
                        //   String password = _password.text;
                        //   // print('이메일 $email 비밀번호 $password');
                        //   // 여기에 로그인 로직을 구현합니다.
                        //   AuthStatus loginStatus =
                        //       await auth.login(email, password);
                        //   if (loginStatus == AuthStatus.loginSuccess) {
                        //   }
                        // }
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
