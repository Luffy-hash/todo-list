import 'package:flutter/material.dart';
import 'package:mytodolist/models/tache.dart';

class UserInput extends StatefulWidget {
  final Function insertFunction; // il recevra notre fonction addItem
  const UserInput({required this.insertFunction, super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final double containerMarginTextField = 12.0;

  // titre
  var textController = TextEditingController();

  // description
  var descController = TextEditingController();

  // date d'écheance
  var dateController = TextEditingController();

  // numero de rue
  var streetNumberController = TextEditingController();

  // adresse
  var streetController = TextEditingController();

  // ville
  var cityController = TextEditingController();

  // code postal
  var codePostalController = TextEditingController();

  // fonction parsing String to int
  int? convertStringToInt(String string) {
    if (string.isNotEmpty) {
      int value = int.parse(string);
      return value;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5EBFF),
        appBar: AppBar(
          title: const Text(
            "Créer une nouvelle tâche",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextFormField(
                controller: textController,
                decoration:
                    const InputDecoration(hintText: "Entrez une phrase *"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
                controller: descController,
                decoration:
                    const InputDecoration(hintText: "Entrez une Description"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              padding: EdgeInsets.symmetric(vertical: containerMarginTextField),
              child: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Entre une date d\'echeance',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? picker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (picker != null) {
                    setState(() {
                      dateController.text = picker.toString();
                    });
                  }
                },
              ),
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
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
                controller: streetNumberController,
                decoration: const InputDecoration(hintText: "N° de rue"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
                controller: streetController,
                decoration:
                    const InputDecoration(hintText: 'Adresse compléte '),
              ),
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
                controller: cityController,
                decoration: const InputDecoration(hintText: 'Ville'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
                controller: codePostalController,
                decoration: const InputDecoration(hintText: 'Code postal'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: containerMarginTextField,
                  horizontal: containerMarginTextField),
              child: const Text(
                "NB : les champs en (*) sont obligatoires",
                style: TextStyle(fontSize: 18),
              ),
            ),
            GestureDetector(
              onTap: () {
                int? streetNumberIns =
                    convertStringToInt(streetNumberController.text);
                int? codePostalIns =
                    convertStringToInt(codePostalController.text);

                print(dateController.text);

                var myTodo = Tache(
                    title: textController.text,
                    isImportant: false,
                    isCompleted: false,
                    description: descController.text,
                    echeance: dateController.text,
                    streetnumber: streetNumberIns,
                    street: streetController.text,
                    city: cityController.text,
                    codePostal: codePostalIns);
                // on passe myTodo à la fonction insertFunction
                if (myTodo.title.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                        return const AlertDialog(
                          title: Text("Error champs requis "),
                          content: Text(
                              "Il faut renseinger obligatoirement le titre"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                        );
                      });
                } else {
                  setState(() {
                    widget.insertFunction(myTodo);
                  });
                  Navigator.pop(context);
                }
              },
              child: Container(
                color: Colors.greenAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 210, vertical: 18),
                child: const Text(
                  "Créer tâche",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ));
  }
}
