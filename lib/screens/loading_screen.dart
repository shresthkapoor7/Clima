import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

Location obj = new Location();

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    double mm;
    SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );
    getLocationData();
    return Scaffold(
      body: SpinKitRotatingPlain(
        color: Colors.white,
        size: 50,
      ),
      // body: SafeArea(
      //   child: Container(
      //     height: 20,
      //     width: mm ?? 200,
      //     color: Colors.red,
      //   ),
      // ),
    );
  }
}
