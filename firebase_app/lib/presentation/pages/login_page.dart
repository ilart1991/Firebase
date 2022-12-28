import 'package:firebase_app/domain/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_home_page.dart';

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
                onPressed: () async {
                  context.read<ItemsProvider>().signInWithEmailAndPassword();
                  if (await Provider.of<ItemsProvider>(context, listen: false)
                      .signInWithEmailAndPassword()
                      .then((value) => value)) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: "Firebase app",
                            )));
                  }
                },
                child: const Text("Войти")),
          ],
        ),
      )),
    );
  }
}
