import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';
import 'package:mytodolist/screens/detail/homedetail.dart';
import 'package:mytodolist/screens/detail/screensdetail/updateuserinput.dart';
import './home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var db = DatabaseConnect();

  // fonction de modif
  void updateItem(Tache tache) async {
    await db.updateTache(tache);
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        '/homedetail': (context) => const Homepagedetail(),
        '/updateUserInput': (context) =>
            UpdateUserInput(updateFunction: updateItem)
      },
    );
  }
}
