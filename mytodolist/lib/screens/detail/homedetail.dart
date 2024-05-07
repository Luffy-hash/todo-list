import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/screens/detail/screensdetail/detail.dart';
import 'package:mytodolist/screens/detail/screensdetail/detailmeteo.dart';

class Homepagedetail extends StatefulWidget {
  const Homepagedetail({super.key});

  @override
  State<Homepagedetail> createState() => _HomepagedetailState();
}

class _HomepagedetailState extends State<Homepagedetail> {
  // connection DB
  var db = DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    // argument partager
    final argument = (ModalRoute.of(context)?.settings.arguments ?? '') as int;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5EBFF),
          appBar: AppBar(
            title: const Text("Details de la tâche"),
            centerTitle: false,
            backgroundColor: Colors.greenAccent,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Details Tâche',
              ),
              Tab(
                text: 'Carte & Météo',
              ),
            ]),
            actions: [
              IconButton(
                  onPressed: () {
                    //redirection vers la page d'update
                      Navigator.pushNamed(context, "/updateUserInput",
                        arguments: argument);
                  },
                  icon: const Icon(Icons.edit)),
            ],
          ),
          body: TabBarView(
            children: [
              // Detail d'une tache
              Detail(
                id: argument,
              ),
              // Carte & Météo
              DetailMeteo(id: argument)
            ],
          ),
        ));
  }
}
