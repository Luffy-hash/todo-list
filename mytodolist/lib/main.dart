import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:mytodolist/models/tache.dart';
import 'package:mytodolist/screens/detail/homedetail.dart';
import 'package:mytodolist/screens/detail/screensdetail/updateuserinput.dart';
import './home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        '/homedetail': (context) => const Homepagedetail(),
      },
    );
  }
}
