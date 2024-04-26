import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';
import 'package:mytodolist/screens/detail/homedetail.dart';
import './home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = DatabaseConnect();
  await db.insertTache(Tache(
      id: 1,
      title: 'Plannification du mois',
      isImportant: true,
      isCompleted: false,
      description: 'une description sur mesure'));
  print(await db.getTache());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Tache tache;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {'/homedetail': (context) => const Homepagedetail()},
    );
  }
}
