import 'package:flutter/material.dart';

class ItemsProvider with ChangeNotifier {
  bool checked = false;

  setCheck() {
    if (checked) {
      checked = false;
    } else {
      checked = true;
    }

    notifyListeners();
    return checked;
  }
}
