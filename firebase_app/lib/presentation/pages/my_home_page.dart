import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/domain/items_provider.dart';
import 'package:firebase_app/domain/firebase_funcs.dart';
import 'package:firebase_app/presentation/widgets/my_listview.dart';
import 'package:firebase_app/presentation/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/item_class.dart';

late CollectionReference<ItemClass> items;
late Query<ItemClass> itemsChecked;
late Query<ItemClass> itemsSorted;

TextEditingController controller = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    items = FirebaseFirestore.instance
        .collection("items")
        .withConverter<ItemClass>(
            fromFirestore: (snapshot, _) =>
                ItemClass.fromJson(snapshot.data()!),
            toFirestore: (item, _) => item.toJson());

    itemsChecked = FirebaseFirestore.instance
        .collection("items")
        .where("bought", isEqualTo: true)
        .withConverter<ItemClass>(
            fromFirestore: (snapshot, _) =>
                ItemClass.fromJson(snapshot.data()!),
            toFirestore: (item, _) => item.toJson());

    itemsSorted = FirebaseFirestore.instance
        .collection("items")
        .orderBy("title")
        .withConverter<ItemClass>(
            fromFirestore: (snapshot, _) =>
                ItemClass.fromJson(snapshot.data()!),
            toFirestore: (item, _) => item.toJson());

    getBackImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ItemsProvider>().setCheck();
                },
                icon: const Icon(Icons.check)),
          ],
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: getBackImage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: NetworkImage(backUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: StreamBuilder(
                  stream: !context.watch<ItemsProvider>().checked
                      ? itemsSorted.snapshots().map((event) {
                          return event.docs.map((e) => e.data()).toList();
                        })
                      : itemsChecked.snapshots().map((event) {
                          return event.docs.map((e) => e.data()).toList();
                        }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          MyListView(snapshot: snapshot),
                          MyTextField(controller: controller),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text("Пусто как в банке из-под анчоусов"));
                    }
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
