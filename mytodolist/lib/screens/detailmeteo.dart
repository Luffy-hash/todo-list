import 'package:flutter/material.dart';

import 'detail.dart';

class DetailMeteo extends StatefulWidget {
  const DetailMeteo({super.key});

  @override
  State<DetailMeteo> createState() => _DetailMeteoState();
}

class _DetailMeteoState extends State<DetailMeteo> {
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
            "Adresse : eazoehaze",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
           
            const Row(children: [Text(
            "Carte : ici ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),

            const Row(children: [Text(
            "Temp min : 1",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),Text(
            "Temp act : 10",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),Text(
            "Temp max : 12",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            )],),
            //Image.asset(''), ici icone soleil ou pluie par exe
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [TextButton(
                onPressed: () {
                  Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => Detail())
                  );
                },
                 child: Text("Détails")),
              TextButton(
                onPressed: () {},
                 child: Text("Adresse et carte"))],
            )
           
        ],),
        
       )
    );
  }
}