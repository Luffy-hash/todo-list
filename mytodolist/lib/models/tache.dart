import 'package:flutter/material.dart';

class Tache {
  int? id;
  String title;
  bool isImportant;
  bool isCompleted;
  String? description;
  DateTime? echeance;
  int? streetnumber;
  String? street;
  String? city;
  int? codePostal;

  // constructeur de notre objet tâche
  Tache(
      {this.id,
      required this.title,
      required this.isImportant,
      required this.isCompleted,
      this.description,
      this.echeance,
      this.streetnumber,
      this.street,
      this.city,
      this.codePostal});

  // Pour stocker nos données dans la db il faut le convertir
  // en une Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isImportant': isImportant
          ? 1
          : 0, // soit il est important ou pas (supporte pas type bool sqlite)
      'isCompleted': isCompleted
          ? 1
          : 0, // soit il est complet ou pas (supporte pas type bool sqlite)
      'description': description,
      'echeance': echeance
          .toString(), // sqlite ne supporte pas le type datetime il faut le convertir en string
      'streetnumber': streetnumber,
      'street': street,
      'city': city,
      'codePostal': codePostal
    };
  }

  // test db
  @override
  String toString() {
    return "Tache(title: $title, isImportant: $isImportant, isCompleted: $isCompleted)";
  }
}
