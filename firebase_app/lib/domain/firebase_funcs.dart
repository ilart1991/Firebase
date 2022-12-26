import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/presentation/pages/login_page.dart';
import 'package:firebase_app/presentation/pages/my_home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app/domain/item_class.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
final _storageRef = FirebaseStorage.instance.ref();
late String backUrl;

signInWithEmailAndPassword(BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginController.text, password: passwordController.text);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyHomePage(
              title: "Firebase app",
            )));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future<String> getBackImage() async {
  backUrl = await _storageRef.child("back.jpg").getDownloadURL();
  return backUrl;
}

changeItemStatus(bool? value, ItemClass e) async {
  QuerySnapshot querySnap = await FirebaseFirestore.instance
      .collection('items')
      .where('title', isEqualTo: e.title)
      .get();
  QueryDocumentSnapshot doc = querySnap.docs[0];
  final ref = _db.collection("items").doc(doc.id);
  ref.update({"bought": value});
}

addNewItem(TextEditingController controller,
    CollectionReference<ItemClass> items) async {
  QuerySnapshot querySnap = await FirebaseFirestore.instance
      .collection('items')
      .where('title', isEqualTo: controller.text)
      .get();

  if (controller.text.isEmpty) {
    return;
  }

  if (querySnap.docs.isEmpty) {
    items.add(ItemClass(controller.text, false));
    controller.clear();
  } else {
    print("${controller.text} уже в списке");
    controller.clear();
  }
}
