import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';

class Detail extends StatelessWidget {
  final int id;
  Detail({
    super.key,
    required this.id,
  });

  final db = DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getTacheById(id),
        builder: (context, snapshot) {
          return SizedBox(
            height: 45,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Text(
                  "Titre : ${snapshot.data?.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Text(
                  "Date : ${snapshot.data?.echeance}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(16.0),
                  child: (snapshot.data?.description != null)
                      ? Text(
                          "Description : ${snapshot.data?.description}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        )
                      : const Text("")),
            ]),
          );
        });
  }
}
