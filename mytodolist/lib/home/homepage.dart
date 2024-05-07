import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';
import 'package:mytodolist/screens/tacheComplet.dart';
import 'package:mytodolist/screens/userinputsearch.dart';
import '../screens/userinput.dart';
import '../screens/list_tache.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // connection DB
  var db = DatabaseConnect();

  // fonction d'ajout
  void addItem(Tache tache) async {
    await db.insertTache(tache);
    setState(() {});
  }

  // fonction de suppression
  void deleteItem(Tache tache) async {
    await db.deleteTache(tache);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5EBFF),
          appBar: AppBar(
            title: const Text("TODO LIST"),
            centerTitle: true,
            backgroundColor: Colors.greenAccent,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Mes Tâches',
              ),
              Tab(
                text: 'Tâche Complètes',
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              // liste de mes taches
              ListeTache(insertFunction: addItem, deleteFunction: deleteItem),
              // mes tache complete
              ListeTacheComplete(
                  insertFunction: addItem, deleteFunction: deleteItem),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInput(
                            insertFunction: addItem,
                          )));
            },
            backgroundColor: Colors.greenAccent,
            child: const Icon(Icons.add_outlined),
          ),
        ));
  }
}
