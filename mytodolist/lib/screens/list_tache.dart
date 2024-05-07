import 'package:flutter/material.dart';
import 'package:mytodolist/models/tache.dart';
import '../models/db_models.dart';
import '../screens/tache_card.dart';

class ListeTache extends StatefulWidget {
  final Function insertFunction;
  final Function deleteFunction;

  const ListeTache(
      {required this.insertFunction, required this.deleteFunction, super.key});

  @override
  State<ListeTache> createState() => _ListeTacheState();
}

class _ListeTacheState extends State<ListeTache> {
  var db = DatabaseConnect();

  final List<String> filterTitlesList = ['importance', 'date echéance'];
  List<Tache> resultFilterData = [];

  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    filterTask();
  }
  //récupère une liste de tache différente selon le filtre actuel
  Future<List<Tache>> filterTask() async {
    if (selectedFilter == "importance") {
      resultFilterData = await db.getTacheOrderImportant();
    } else if (selectedFilter == "date echéance") {
      resultFilterData = await db.getTacheOrderDateEcheance();
    } else {
      resultFilterData = await db.getTacheNotCompleted();
    }
    return resultFilterData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: const Text(
                    "Trier la tache",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButton<String>(
                    hint: const Text(
                      "Toutes mes tâches incomplètes",
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                    icon: const Icon(Icons.import_export_sharp),
                    isExpanded: true,
                    value: selectedFilter,
                    onChanged: (String? value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                    items:
                  //menu filtres
                        filterTitlesList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        //liste des taches
        Expanded(
          child: FutureBuilder(
              future: filterTask(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Erreur : ${snapshot.error}"),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Pas de tâches"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    //objet tache card dans la liste
                    itemBuilder: (context, index) => TacheCard(
                      id: snapshot.data![index].id,
                      title: snapshot.data![index].title,
                      isImportant: snapshot.data![index].isImportant,
                      isCompleted: snapshot.data![index].isCompleted,
                      echeance: (snapshot.data![index].echeance == null)
                          ? const Text("")
                          : snapshot.data![index].echeance.split(' ')[0],
                      insertFunction: widget.insertFunction,
                      deleteFunction: widget.deleteFunction,
                    ),
                  );
                }
              }),
        )
      ],
    );
  }
}
