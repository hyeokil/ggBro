import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/screens/member/component/custom_input.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _nickname.dispose();
    _password.dispose();
    _passwordCheck.dispose();
    super.dispose();
  }

  // 비밀번호, 비밀번호 확인 유효성 검사 함수
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
    if (_password.text != _passwordCheck.text) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailField(controller: _email),
              NicknameField(controller: _nickname),
              PasswordField(
                controller: _password,
                validator: _validatePassword,
              ),
              PasswordCheckField(
                controller: _passwordCheck,
                validator: _validatePassword,
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
                        final auth = Provider.of<AuthModel>(context, listen: false);
                        if (_formKey.currentState!.validate()) {
                          // 유효성 검사를 통과한 경우 회원가입 로직을 실행합니다.
                          String email = _email.text;
                          String password = _password.text;
                          String nickName = _nickname.text;
                          // Fluttertoast.showToast(
                          //     msg: "회원가입 성공",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.TOP,
                          //     timeInSecForIosWeb: 2,
                          //     backgroundColor: Colors.green,
                          //     textColor: Colors.white,
                          //     fontSize: 20.0);
                          print('이메일 $email 비밀번호 $password 닉네임 $nickName');
                          // 여기에 회원가입 로직을 구현합니다.
                          auth.signUp(email, password, nickName);
                        }
                      },
                      child: const Text("회원가입"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      keyboard: TextInputType.emailAddress,
      icon: const Icon(Icons.mail),
      hint: "Email",
      label: "이메일",
      validator: (value) {
        // 이메일 유효성 검사 정규 표현식
        final emailRegex = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          caseSensitive: false,
          multiLine: false,
        );

        if (value == null || value.isEmpty) {
          return '이메일을 입력하세요.';
        } else if (!emailRegex.hasMatch(value)) {
          return '올바른 이메일 주소를 입력하세요.';
        }
        return null;
      },
    );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;
  const NicknameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      icon: const Icon(Icons.person),
      hint: "Nickname",
      label: "닉네임",
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      icon: const Icon(Icons.lock),
      hint: "password",
      label: "비밀번호",
      obscure: true,
      validator: validator,
    );
  }
}

class PasswordCheckField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const PasswordCheckField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      obscure: true,
      icon: const Icon(Icons.check),
      hint: "Password Check",
      label: "비밀번호 확인",
      validator: validator,
    );
  }
}
