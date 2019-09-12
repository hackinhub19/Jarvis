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
    var cropName="Maize";
    return Scaffold(
      backgroundColor: Colors.teal,
      body:
      Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                constraints: BoxConstraints(
//                    maxHeight: 300.0,
                    maxWidth: 1500.0,
                    minWidth: 1500.0,
//                    minHeight: 50.0
                ),

//                color: Colors.redAccent,
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.grey,
                  constraints: BoxConstraints(
//                    maxHeight: 300.0,
                    maxWidth: 1500.0,
                    minWidth: 1500.0,
//                    minHeight: 50.0
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        alignment: Alignment.center,child: Text("Crop Name: $cropName",style:
                    TextStyle(fontSize: 30.0,color: Colors.black) ,)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(

                constraints: BoxConstraints(
//                    maxHeight: 100.0,
                  maxWidth: 1500.0,
                  minWidth: 510.0,
//                    minHeight: 50.0
                ),
                color: Colors.greenAccent.shade200 ,
//                alignment: Alignment.topLeft,
//              margin: EdgeInsets.fromLTRB(100.0, 100.0, 15.0, 100.0),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Your Location: ${finalCity == null ? util.defaultCity : finalCity}",style: TextStyle(fontSize: 30.0,color: Colors.white)
              ),
                  ),
                ),
            ),),
            updateWeather(
                "${finalCity == null ? util.defaultCity : finalCity}"
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 200, 0.0, 0.0),
              child: FlatButton(
                color:Colors.greenAccent.shade200 ,
                child: Text(
                    "Get Analysis of Irrigation",style: TextStyle(fontSize: 30.0,color: Colors.white)
                ),
                onPressed: ()=>print("hi"),
              ),
            )
//            Container(
//              alignment: Alignment.center,
//              margin: EdgeInsets.fromLTRB(130.0, 130.0, 0.0, 15.0),
//              child: Image.asset("images/light_rain.png"),
//            ),

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
//              margin: EdgeInsets.fromLTRB(50.0, 200.0, 0.0, 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(

//                      constraints: BoxConstraints(
////                    maxHeight: 100.0,
//                        maxWidth: 1500.0,
//                        minWidth: 510.0,
////                    minHeight: 50.0
//                      ),
                      color: Colors.greenAccent.shade200 ,
//                alignment: Alignment.topLeft,
//              margin: EdgeInsets.fromLTRB(100.0, 100.0, 15.0, 100.0),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("TEMPERATURE\n\n"+
                            content['main']['temp'].toString() + " °C\n",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(

//                      constraints: BoxConstraints(
////                    maxHeight: 100.0,
//                        maxWidth: 1500.0,
//                        minWidth: 510.0,
////                    minHeight: 50.0
//                      ),
                      color: Colors.greenAccent.shade200 ,
//                alignment: Alignment.topLeft,
//              margin: EdgeInsets.fromLTRB(100.0, 100.0, 15.0, 100.0),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "HUMIDITY\n\n  " +
                                content['main']['humidity'].toString() +
                                " °C\n",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                        ),
                      ),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.redAccent,
                      child: Row(

                        children: <Widget>[

                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else
            return Container();
        });
  }
}




