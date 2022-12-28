import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/login_page.dart';

class ItemsProvider with ChangeNotifier {
  bool checked = false;
  bool logged = false;

  setCheck() {
    if (checked) {
      checked = false;
    } else {
      checked = true;
    }

    notifyListeners();
    return checked;
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginController.text, password: passwordController.text);
      logged = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
    return logged;
  }
}
