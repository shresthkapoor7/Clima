import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  num temprature;
  num condition;
  String cityName;
  String temp;
  String message;
  String weatherIcon;
  WeatherModel objWeatherModel = new WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        temp = temprature.toStringAsFixed(0);
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      temprature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      temp = temprature.toStringAsFixed(0);

      message = objWeatherModel.getMessage(int.parse(temp));
      weatherIcon = objWeatherModel.getWeatherIcon(condition);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.near_me,
            size: 30,
          ),
          onPressed: () async {
            var weatherData = await objWeatherModel.getLocationWeather();
            updateUI(weatherData);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.location_city, size: 30),
              onPressed: () async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CityScreen()),
                );
                if (typedName != null) {
                  var weatherData =
                      await objWeatherModel.getCityWeather(cityName);
                  print(weatherData);
                  updateUI(weatherData);
                }
              }),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$temp??',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  '$message in $cityName!',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 