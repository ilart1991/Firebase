import 'package:flutter/material.dart';

import '../../domain/firebase_funcs.dart';

TextEditingController loginController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                  hintText: "Электронная почта", helperText: "skillbox@ya.ru"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Пароль", helperText: "17011991"),
            ),
            ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword(context);
                },
                child: const Text("Войти")),
          ],
        ),
      )),
    );
  }
}
