import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';

class Detail extends StatelessWidget {
  var db = DatabaseConnect();
  final int id;
  Detail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {

      return FutureBuilder(
        future: db.getTacheById(id),
         builder: (context, snapshot){
             return SizedBox(
              child: Column(
          children: [
             Row(children: [Text(
            "Titre : ${snapshot.data?.title}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
           
            Row(children: [Text(
            "Date : ${snapshot.data?.echeance}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),

            Row(children: [Text(
            "Description : ${snapshot.data?.description}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
            ]),
            );
         });
  }
}
