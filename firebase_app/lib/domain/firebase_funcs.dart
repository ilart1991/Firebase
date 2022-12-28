import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app/domain/item_class.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
final _storageRef = FirebaseStorage.instance.ref();
late String backUrl;

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
    controller.clear();
  }
}
