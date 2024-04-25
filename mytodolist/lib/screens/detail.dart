import 'package:flutter/material.dart';
import 'package:mytodolist/screens/detailmeteo.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(actions: [
        IconButton(
        onPressed: () {print("R appuyé");},
        icon: Image.asset('assets/images/retour.png'),
        iconSize: 5,),
        IconButton(
        onPressed: () {print("M appuyé");},
        icon: Image.asset('assets/images/modif.png'),
        iconSize: 5),
        IconButton(
        onPressed: () {print("I appuyé");},
        icon: Image.asset('assets/images/important.png'),
        iconSize: 5),
        IconButton(
        onPressed: () {print("S appuyé");},
        icon: Image.asset('assets/images/poubelle.png'),
        iconSize: 5)
       ],),
       body: Container(
        constraints: BoxConstraints(),
        child:  Column(
          children: [
            const Row(children: [Text(
            "Titre : eazoehaze",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
           
            const Row(children: [Text(
            "Date : prout",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),

            const Row(children: [Text(
            "Description : eazoehaze",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [TextButton(
                onPressed: () {},
                 child: Text("Détails")),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => DetailMeteo())
                  );
                },
                 child: Text("Adresse et carte"))],
            )
           
        ],),
        
       )
    );
  }
}