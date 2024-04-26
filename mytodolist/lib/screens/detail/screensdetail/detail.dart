import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';

class Detail extends StatelessWidget {
  var db = DatabaseConnect();
  final int id;
  Detail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
          future: db.getTacheById(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data.toString().isEmpty) {
              return Center(
                child: Text(data.toString()),
              );
            }

            return data;
          }),
    );
  }
}
