import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';

import 'detail.dart';

class DetailMeteo extends StatelessWidget {
  var db = DatabaseConnect();
  final int id;
  DetailMeteo({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getTacheById(id),
         builder: (context, snapshot){
             return SizedBox(
              child: Column(
          children: [
             Row(children: [Text(
            "Adresse : ${snapshot.data?.streetnumber} ${snapshot.data?.street}, ${snapshot.data?.codePostal} ${snapshot.data?.city}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
           
            const Row(children: [Text(
            "carte ici"),],),

            const Row(children: [Text(
            "température + icone ici"),],),
            ]),
            );
         });
  }
}
