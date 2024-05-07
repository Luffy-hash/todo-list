import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mytodolist/models/db_models.dart';
import 'package:http/http.dart' as http;

import '../../../models/tache.dart';
import 'detail.dart';

class DetailMeteo extends StatefulWidget {
  final int id;
  DetailMeteo({super.key, required this.id});

 
  @override
  State<DetailMeteo> createState() => _DetailMeteoState();
}

class _DetailMeteoState extends State<DetailMeteo> {
  var db = DatabaseConnect();
  //initiialisation des variables de la page
  double _min = 0;

  double _moy = 0;

  double _max = 0;

  LatLng _coords = LatLng(46.6061, 1.8752);
  
  bool _mapCreated = false;

  Set<Marker> location = Set();
  //image par défaut pour éviter de lancer une requête avec un nom vide
  var _icon = "10n";

  late GoogleMapController mapController;
  //initialise la carte google 
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
     _mapCreated = true;
    });
  }
  //récupère la latitude et la longitute de l'adresse passée en paramètres
  Future<void> _getLatLong(String address) async {

    final api = "AIzaSyDhYXaBrAlrKAUj_Mjbyvc4bAPebVFIy3A";
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$api';

    final reponse = await http.get(Uri.parse(url));

    if (reponse.statusCode == 200) {
      Map<String, dynamic> data = json.decode(reponse.body);
      if(mounted){
        //si on des résultats on change la position de la caméra ainsi que le marker
        if(data['status'] != "ZERO_RESULTS"){
          setState(() {
            _coords = LatLng(data["results"][0]["geometry"]["location"]["lat"], data["results"][0]["geometry"]["location"]["lng"]);
            mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _coords, zoom: 15)));
            location.add(Marker(markerId: MarkerId("location"),position: _coords));
          });
        }
        
      }
    } 
    else{
      print('erreur');
    }
  }
  //récupère la météo de la vile passée en paramètre
  Future<void> _obtenirMeteo(String city) async {
      const apiKey =
        '8a2197bbb3b34282c157fa4019483f44'; // La clé API à demander sur OpenWeatherMap
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=fr';

    final reponse = await http.get(Uri.parse(apiUrl));
    //si la requête a aboutie on update les données de température
    if (reponse.statusCode == 200) {
      Map<String, dynamic> meteoData = json.decode(reponse.body);
      if(mounted){
        setState(() {
        _moy = meteoData['main']['temp'];
        _min = meteoData['main']['temp_min'];
        _max = meteoData['main']['temp_max'];
        _icon = meteoData['weather'][0]['icon'];
      });
      }
      
    } else {
      setState(() {
        _max = 9999;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.getTacheById(widget.id),
        builder: (context, snapshot) {
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                            margin: const EdgeInsets.all(16.0),
                            child: Builder(builder: (context) 
                            {
                              //si la ville ET la rue ne sont pas indiquées on affiche juste un texte 
                              if((snapshot.data?.city == null || snapshot.data?.city == "") &&
                              (snapshot.data?.street == null || snapshot.data?.street == "")){
                                return const SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Vous n'avez pas renseigné d'adresse ou adresse invalide",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                              }else{
                                return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${snapshot.data?.streetnumber} ${snapshot.data?.street}, ${snapshot.data?.codePostal} ${snapshot.data?.city}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                              }
                            },),
                            
                          ),
                          Container(
                            height: 200,
                            width: 350,
                            child: Builder(builder: (context){
                              //si la map est créée alors on peut effectuer des changements sur celle ci
                              if(snapshot.data != null && _mapCreated){
                                  var fulladdress = "${snapshot.data!.streetnumber} ${snapshot.data!.street}, ${snapshot.data!.codePostal} ${snapshot.data!.city}";
                                  _getLatLong(fulladdress);
                              }
                              if((snapshot.data?.city == null || snapshot.data?.city == "") &&
                              (snapshot.data?.street == null || snapshot.data?.street == "")){
                                return const Text("");
                              }
                              //si on a au moins une ville ou une adresse on affiche la carte
                              else{
                                _coords = _coords;
                                return GoogleMap(onMapCreated: _onMapCreated,
                                initialCameraPosition: 
                                CameraPosition(target: _coords,zoom:11),
                                markers: location,);
                                
                              }
                              
                            }
                            ,)
                          ),
                          Container(
                              margin: const EdgeInsets.all(16.0),
                              child: Builder(
                                builder: ((context) {
                                  var ville = snapshot.data?.city;
                                  if (ville != null && ville.isNotEmpty) {
                                    //si les valeurs sont toujours celle de base on fait la requete pour la meteo
                                    if(_min == 0 && _moy == 0 && _max == 0 ){
                                      _obtenirMeteo(ville);
                                    }
                                    //si la veleur de max est 9999 ça veut dire qu'on a un erreur et donc on affiche rien
                                    if(_max != 9999){
                                      return (Column(children: [
                                      Text(
                                          "Min : ${_min}, Act : ${_moy}, Max : ${_max}"),
                                      Image.network(
                                          "http://openweathermap.org/img/w/${_icon}.png")
                                      ]));
                                    }
                                    else{
                                      return const Text("");
                                    }
                                  } else {
                                    return const Text("");
                                  }
                                }),
                              ))
                        ]),
            )
                 
          );
        });
  }
}
