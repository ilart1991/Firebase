import 'package:flutter/material.dart';

import '../../domain/firebase_funcs.dart';
import '../pages/my_home_page.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MyTextField({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Наименование товара",
            suffix: ElevatedButton(
              child: const Text("Добавить"),
              onPressed: () async {
                addNewItem(controller, items);
              },
            )),
      ),
    );
  }
}
