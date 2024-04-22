import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = Db();
  await db.insertTache(
      Tache(title: 'tu fait bien', isImportant: false, isCompleted: false));
  print(db.getTache());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(),
    );
  }
}
