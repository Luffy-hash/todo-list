import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:http/http.dart' as http;

import 'detail.dart';

class DetailMeteo extends StatelessWidget {
  var db = DatabaseConnect();
  final int id;
  DetailMeteo({super.key, required this.id});

  double _min = 0;
  double _moy = 0;
  double _max = 0;
  //marche pas pour l'instant donc valeur par défaut 
  var _icon = "10n";

  Future<void> _obtenirMeteo(String city) async {
    const apiKey = '8a2197bbb3b34282c157fa4019483f44'; // La clé API à demander sur OpenWeatherMap
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=fr';

    final reponse = await http.get(Uri.parse(apiUrl));

    if (reponse.statusCode == 200) {
      Map<String, dynamic> meteoData = json.decode(reponse.body);
        _moy = meteoData['main']['temp'];
        _min = meteoData['main']['temp_min'];
        _max = meteoData['main']['temp_max'];
        //censé recup le nom de l'image _icon = meteoData['weather'][0]['icon'];
    } else {
      throw Exception('Echec lors de la récupération des données');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getTacheById(id),
         builder: (context, snapshot){
             return SizedBox(
              child: Column(
          children: [
             Row(children: [Text(
            "Adresse : ${snapshot.data?.streetnumber} ${snapshot.data?.street}, ${snapshot.data?.codePostal} ${snapshot.data?.city}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),],),
           
            const Row(children: [Text(
            "carte ici"),],),

            Row(children: [Container(
              child: Builder(builder: (context){
                var ville = snapshot.data?.city;
                if(ville != null && ville.isNotEmpty){
                  _obtenirMeteo(ville);
                  return (Column(children: [
                    Text("Min : ${_min}, Act : ${_moy}, Max : ${_max}"),
                    Image.network("http://openweathermap.org/img/w/${_icon}.png")]));
                }
                else{
                  return Text("Pas de ville entrée");
                }
              }
              ,),
            ),],),
            ]),
            );
         });
  }
}
