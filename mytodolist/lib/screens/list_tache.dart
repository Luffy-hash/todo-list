import 'package:flutter/material.dart';
import '../models/db_models.dart';
import '../screens/tache_card.dart';

class ListeTache extends StatelessWidget {
  var db = DatabaseConnect();
  final Function insertFunction;
  final Function deleteFunction;

  ListeTache(
      {required this.insertFunction, required this.deleteFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: FutureBuilder(
          future: db.getTache(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var data = snapshot.data;
            var dataLength = data!.length;
            return dataLength == 0
                ? const Center(
                    child: Text("pas de tâche"),
                  )
                : ListView.builder(
                    itemCount: dataLength,
                    itemBuilder: (context, index) => TacheCard(
                        id: data[index].id,
                        title: data[index].title,
                        isImportant: data[index].isImportant,
                        isCompleted: data[index].isCompleted,
                        echeance: data[index].echeance,
                        insertFunction: insertFunction,
                        deleteFunction: deleteFunction));
          }),
    );
  }
}
