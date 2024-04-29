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
        builder: (context, snapshot) {
          return SizedBox(
            child: (snapshot.data?.street != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Text(
                            "Adresse : ${snapshot.data?.streetnumber} ${snapshot.data?.street}, ${snapshot.data?.codePostal} ${snapshot.data?.city}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: const Text("Carte"),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: const Text("Données météo"),
                        )
                      ])
                : const SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                        ),
                        Text("Vous n'avez pas renseigner d'adresse",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
          );
        });
  }
}
