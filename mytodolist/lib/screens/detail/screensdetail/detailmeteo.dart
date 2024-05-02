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

  double _min = 0;

  double _moy = 0;

  double _max = 0;

  LatLng _coords = LatLng(46.6061, 1.8752);

  bool _mapCreated = false;

  Set<Marker> location = Set();

  //marche pas pour l'instant donc valeur par défaut
  var _icon = "10n";

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
     _mapCreated = true;
    });
  }
  //TODO update map quand on update l'adresse
  Future<void> _getLatLong(String address) async {

    final api = "AIzaSyDhYXaBrAlrKAUj_Mjbyvc4bAPebVFIy3A";
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$api';

    final reponse = await http.get(Uri.parse(url));

    if (reponse.statusCode == 200) {
      Map<String, dynamic> data = json.decode(reponse.body);
      if(mounted){
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

  Future<void> _obtenirMeteo(String city) async {
      const apiKey =
        '8a2197bbb3b34282c157fa4019483f44'; // La clé API à demander sur OpenWeatherMap
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=fr';

    final reponse = await http.get(Uri.parse(apiUrl));

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
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Builder(builder: (context) 
                          {
                            if((snapshot.data?.city == null || snapshot.data?.city == "") &&
                            (snapshot.data?.street == null || snapshot.data?.street == "")){
                              return const SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Vous n'avez pas renseigné d'adresse",
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
                            if(snapshot.data != null && _mapCreated){
                                var fulladdress = "${snapshot.data!.streetnumber} ${snapshot.data!.street}, ${snapshot.data!.codePostal} ${snapshot.data!.city}";
                                _getLatLong(fulladdress);
                            }
                            _coords = _coords;
                            return GoogleMap(onMapCreated: _onMapCreated,
                            initialCameraPosition: 
                            CameraPosition(target: _coords,zoom:6),
                            markers: location,);
                          }
                          ,)
                        ),
                        Container(
                            margin: const EdgeInsets.all(16.0),
                            child: Builder(
                              builder: ((context) {
                                var ville = snapshot.data?.city;
                                if (ville != null && ville.isNotEmpty) {
                                  if(_min == 0 && _moy == 0 && _max == 0 ){
                                    _obtenirMeteo(ville);
                                  }
                                  if(_max != 9999){
                                    return (Column(children: [
                                    Text(
                                        "Min : ${_min}, Act : ${_moy}, Max : ${_max}"),
                                    Image.network(
                                        "http://openweathermap.org/img/w/${_icon}.png")
                                    ]));
                                  }
                                  else{
                                    return const Text("Ville invalide");
                                  }
                                } else {
                                  return const Text("Pas de ville entrée");
                                }
                              }),
                            ))
                      ])
                 
          );
        });
  }
}
