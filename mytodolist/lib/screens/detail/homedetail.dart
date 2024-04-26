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
    print(argument);

    // fonction get element by id
    void getItemById() async {
      await db.getTacheById(argument);
      setState(() {});
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5EBFF),
          appBar: AppBar(
            title: const Text("Detail Carte & Météo Tâche"),
            centerTitle: false,
            backgroundColor: Colors.greenAccent,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Details Tache',
              ),
              Tab(
                text: 'Carte & Météo',
              ),
            ]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.radio_button_checked)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
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
