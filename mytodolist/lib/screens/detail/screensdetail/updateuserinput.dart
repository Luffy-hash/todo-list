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

    // fonction parsing String to int
    int? convertStringToInt(String string) {
      if (string.isNotEmpty) {
        int value = int.parse(string);
        return value;
      }

      return null;
    }

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
                            decoration:
                                InputDecoration(hintText: snapshot.data!.title),
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
                                        hintText: "Description"),
                                  )),
                        Container(
                            margin: const EdgeInsets.all(16.0),
                            child: TextField(
                                    controller: echeanceUpdateController,
                                    decoration: InputDecoration(
                                      hintText:
                                          snapshot.data!.echeance.toString(),
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? picker = await showDatePicker(
                                          context: this.context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100));
                                      if (picker != null) {
                                        setState(() {
                                          echeanceUpdateController.text =
                                              picker.toString();
                                        });
                                      }
                                    },
                                  )
                                ),
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
                                  controller: streetNumberUpdateController,
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
                                  controller: streetUpdateController,
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
                                  controller: cityUpdateController,
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
                                  controller: codePostalUpdateController,
                                  decoration: const InputDecoration(
                                      hintText: "Code Postal"),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            int? streetNumberUpd = convertStringToInt(
                                streetNumberUpdateController.text);
                            int? codePostalUpd = convertStringToInt(
                                codePostalUpdateController.text);

                            if (titleUpdateController.text.isEmpty) {
                              titleUpdateController.text = snapshot.data!.title;
                            }

                            if (descUpdateController.text.isEmpty ) {
                              descUpdateController.text =
                                  snapshot.data!.description!;
                            }

                            if (echeanceUpdateController.text.isEmpty) {
                              echeanceUpdateController.text =
                                  snapshot.data!.echeance!;
                            }

                            if (streetUpdateController.text.isEmpty ) {
                              streetUpdateController.text =
                                  snapshot.data!.street!;
                            }

                            if (streetNumberUpdateController.text.isEmpty ) {
                              streetNumberUpd =
                                  snapshot.data!.streetnumber!;
                            }

                            if (codePostalUpdateController.text.isEmpty ) {
                              codePostalUpd =
                                  snapshot.data!.codePostal!;
                            }

                            if (cityUpdateController.text.isEmpty ) {
                              cityUpdateController.text =
                                  snapshot.data!.city!;
                            }

                            var myUpdateTodo = Tache(
                                id: idArgsUpdate,
                                title: titleUpdateController.text,
                                isImportant: false,
                                isCompleted: false,
                                description: descUpdateController.text,
                                echeance: echeanceUpdateController.text,
                                streetnumber: streetNumberUpd,
                                street: streetUpdateController.text,
                                city: cityUpdateController.text,
                                codePostal: codePostalUpd);
                            setState(() {
                              widget.updateFunction(myUpdateTodo);
                            });
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
