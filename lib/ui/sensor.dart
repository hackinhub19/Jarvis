import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import'package:smartfarmland/utils/utils.dart' as util;
import 'package:http/http.dart' as http;




class sensor extends StatefulWidget {
  @override
  _sensorState createState() => _sensorState();
}

class _sensorState extends State<sensor> {
  String finalCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
//        width: MediaQuery
//            .of(context)
//            .size
//            .width,
//        height: MediaQuery
//            .of(context)
//            .size
//            .height,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage("images/umbrella.png"),
//                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 0.0),
              child: Text(
                "${finalCity == null ? util.defaultCity : finalCity}",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(130.0, 130.0, 0.0, 15.0),
              child: Image.asset("images/light_rain.png"),
            ),
            updateWeather(
                "${finalCity == null ? util.defaultCity : finalCity}"
            )
          ],
        ),
      ),

    );
  }

  Future<Map> getWeather(String appID, String city) async {
    String apiURL = "https://api.openweathermap.org/data/2.5/weather?q="
        "$city&appid=$appID&units=metric";
    http.Response response = await http.get(apiURL);
    return json.decode(response.body);
  }

  Widget updateWeather(String city) {
    return FutureBuilder(
        future: getWeather(
            util.apiKey, city == null ? city = util.defaultCity : city),
        builder: (BuildContext content, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Container(
              margin: EdgeInsets.fromLTRB(50.0, 280.0, 0.0, 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      content['main']['temp'].toString() + " °C\n",
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                    subtitle: Text(
                      "Humidity:" +
                          content['main']['humidity'].toString() +
                          " °C\n",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            );
          } else
            return Container();
        });
  }
}




