import 'package:flutter/material.dart';
import 'package:mytodolist/models/tache.dart';

class UserInput extends StatefulWidget {
  final Function insertFunction; // il recevra notre fonction addItem
  const UserInput({required this.insertFunction, super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final double containerMarginTextField = 16.0;

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
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(containerMarginTextField),
              child: TextField(
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
                      context: this.context,
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
                    const InputDecoration(hintText: 'Adresse complète '),
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
                if (dateController.text == Null) {
                  dateController.text == '';
                }
                var myTodo = Tache(
                    title: textController.text,
                    isImportant: false,
                    isCompleted: false,
                    description: descController.text,
                    streetnumber: int.parse(streetNumberController.text),
                    street: streetController.text,
                    city: cityController.text,
                    echeance: DateTime.parse(dateController.text),
                    codePostal: int.parse(codePostalController.text));
                // on passe myTodo à la fonction insertFunction
                widget.insertFunction(myTodo);
                Navigator.pop(context);
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
