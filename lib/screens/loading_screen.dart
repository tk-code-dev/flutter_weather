import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text('button'),
        ),
      ),
    );
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude.toString() + " : " + location.longitude.toString());
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      int id = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String cityName = decodedData['name'];
      String discription = decodedData['weather'][0]['description'];
      print(temperature.toString() + cityName + id.toString() + discription);
    } else {
      print(response.statusCode);
    }
  }
}
