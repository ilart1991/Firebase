import 'package:flutter/material.dart';

import '../../domain/firebase_funcs.dart';
import '../../domain/item_class.dart';

class MyListView extends StatelessWidget {
  final AsyncSnapshot<List<ItemClass>> snapshot;

  const MyListView({super.key, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
          children: snapshot.data!.map((e) {
        return ListTile(
          title: Text(e.title),
          trailing: Checkbox(
            value: e.bought,
            onChanged: (value) async {
              changeItemStatus(value, e);
            },
          ),
        );
      }).toList()),
    );
  }
}
