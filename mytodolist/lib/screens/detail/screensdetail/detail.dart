import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';

class Detail extends StatefulWidget {
  final int id;
  const Detail({
    super.key,
    required this.id,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final db = DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getTacheById(widget.id),
        builder: (context, snapshot) {
          return SizedBox(
            height: 45,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Text(
                  "${snapshot.data?.title}",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(16.0),
                  child: (snapshot.data?.description != null)
                      ? Text(
                          "${snapshot.data?.description}",
                          style: const TextStyle(fontSize: 25),
                        )
                      : const Text("")),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Text(
                  "${snapshot.data?.echeance}",
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ]),
          );
        });
  }
}
