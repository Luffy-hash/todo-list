import 'package:flutter/material.dart';
import 'package:mytodolist/models/tache.dart';
import 'package:mytodolist/screens/userinputsearch.dart';

class TacheCard extends StatefulWidget {
  final int id;
  final String title;
  final bool isImportant;
  final bool isCompleted;
  final DateTime? echeance;
  final Function insertFunction;
  final Function deleteFunction;
  const TacheCard(
      {required this.id,
      required this.title,
      required this.isImportant,
      required this.isCompleted,
      required this.echeance,
      required this.insertFunction,
      required this.deleteFunction,
      super.key});

  @override
  State<TacheCard> createState() => _TacheCardState();
}

class _TacheCardState extends State<TacheCard> {
  @override
  Widget build(BuildContext context) {
    var anotherTodo = Tache(
        id: widget.id,
        title: widget.title,
        echeance: widget.echeance,
        isImportant: widget.isImportant,
        isCompleted: widget.isCompleted);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/homedetail', arguments: anotherTodo.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Row(
          children: [
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Checkbox(
                  value: widget.isCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isCompleted == value!;
                    });
                    anotherTodo.isCompleted = value!;
                    widget.insertFunction(anotherTodo);
                  }),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.echeance}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8F8F8F),
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            SizedBox(
                child: Checkbox(
              value: widget.isImportant,
              onChanged: (bool? value) {
                setState(() {
                  widget.isImportant == value!;
                });
                anotherTodo.isImportant = value!;
                widget.insertFunction(anotherTodo);
              },
            )),
            IconButton(
              onPressed: () {
                widget.deleteFunction(anotherTodo);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
