import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';

class UpdateUserInput extends StatefulWidget {
  final Function updateFunction;

  const UpdateUserInput({required this.updateFunction, super.key});

  @override
  State<UpdateUserInput> createState() => _UpdateUserInputState();
}

class _UpdateUserInputState extends State<UpdateUserInput> {
  @override
  Widget build(BuildContext context) {
    var db = DatabaseConnect();

    final idArgsUpdate =
        (ModalRoute.of(context)?.settings.arguments ?? '') as int;

    var titleUpdateController = TextEditingController();

    var descUpdateController = TextEditingController();

    var echeanceUpdateController = TextEditingController();

    var streetNumberUpdateController = TextEditingController();

    var streetUpdateController = TextEditingController();

    var cityUpdateController = TextEditingController();

    var codePostalUpdateController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5EBFF),
      appBar: AppBar(
        title: const Text(
          "Mettre à jour la tâche ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SizedBox(
        child: FutureBuilder(
            future: db.getTacheById(idArgsUpdate),
            builder: (context, snapshot) {
              var data = snapshot.hasData;

              return data
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: titleUpdateController,
                            decoration: InputDecoration(
                                label: Text(snapshot.data!.title)),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.all(16.0),
                            child: (snapshot.data!.description != null)
                                ? TextField(
                                    controller: descUpdateController,
                                    decoration: InputDecoration(
                                        hintText: snapshot.data!.description),
                                  )
                                : TextField(
                                    controller: descUpdateController,
                                    decoration: const InputDecoration(
                                        hintText: "Donnez votre description"),
                                  )),
                        Container(
                            margin: const EdgeInsets.all(16.0),
                            child: (snapshot.data!.echeance != null)
                                ? TextField(
                                    controller: echeanceUpdateController,
                                    decoration: InputDecoration(
                                      labelText:
                                          snapshot.data!.echeance.toString(),
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                  )
                                : TextField(
                                    controller: descUpdateController,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Une date d'écheance s'il vous plaît!"),
                                  )),
                        const SizedBox(
                          height: 25,
                          width: 470,
                          child: SizedBox(
                            child: Text(
                              "Adresse",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: (snapshot.data!.streetnumber != null)
                              ? TextField(
                                  controller: streetNumberUpdateController,
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!.streetnumber
                                          .toString()),
                                )
                              : TextField(
                                  controller: descUpdateController,
                                  decoration: const InputDecoration(
                                      hintText: "N° de rue"),
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: (snapshot.data!.street != null)
                              ? TextField(
                                  controller: streetUpdateController,
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!.street),
                                )
                              : TextField(
                                  controller: descUpdateController,
                                  decoration: const InputDecoration(
                                      hintText: "Adresse compléte"),
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: (snapshot.data!.street != null)
                              ? TextField(
                                  controller: cityUpdateController,
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!.city),
                                )
                              : TextField(
                                  controller: descUpdateController,
                                  decoration:
                                      const InputDecoration(hintText: "Ville"),
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: (snapshot.data!.codePostal != null)
                              ? TextField(
                                  controller: codePostalUpdateController,
                                  decoration: InputDecoration(
                                      hintText:
                                          snapshot.data!.codePostal.toString()),
                                )
                              : TextField(
                                  controller: descUpdateController,
                                  decoration: const InputDecoration(
                                      hintText: "Code Postal"),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            var myUpdateTodo = Tache(
                              id: idArgsUpdate,
                              title: titleUpdateController.text,
                              isImportant: false,
                              isCompleted: false,
                              description: descUpdateController.text,
                              street: streetUpdateController.text,
                              city: cityUpdateController.text,
                            );
                            widget.updateFunction(myUpdateTodo);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 180, vertical: 15),
                            child: const Text(
                              "Mettre à jour",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    )
                  : const Center(child: Text("Oups petit soucis..."));
            }),
      ),
    );
  }
}
