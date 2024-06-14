//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/utils/weather.dart';
//import 'package:flutter_launcher_icons/android.dart';
// import 'package:http/http.dart';

//import '../utils/location.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  //const MainScreen({super.key});

  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  //late final WeatherData weatherData;
  int? temperature;
  int? pressure;
  int? humidity;
  int? wind;
  int? feels_like;
  Icon? weatherDisplayIcon;
  //AssetImage backgroundImage;
  String? city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature?.round();
      pressure = weatherData.currentPressure;
      humidity = weatherData.currentHumidity as int?;
      wind = weatherData.currentWind?.round();
      feels_like = weatherData.currentFeelsLike?.round();
      city = weatherData.city;

      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      //backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      updateDisplayInfo(widget.weatherData);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      setState(() {
        updateDisplayInfo(widget.weatherData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.blue],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
              margin: EdgeInsets.only(top: 50),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: TextStyle(
                    color: Colors.white, fontSize: 70.0, letterSpacing: -5),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city != null ? city! : "Bilinmeyen Şehir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
            Divider(
              indent: 50, //sola boşluk
              endIndent: 50, // sağa boşluk
            ),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/img/pressure.png')),
                  Text(
                    'Basınç: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      '$pressure mb',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  )
                ],
              ),
            )),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/img/humidity.png'),
                        ),
                        Text(
                          'Nem:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            '%$humidity',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                      ],
                    ))),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset('assets/img/wind.png')),
                        Text(
                          'Rüzgar:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            '${wind} m/sn',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        )
                      ],
                    ))),
            SizedBox(
              height: 15,
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon:
                                Image.asset('assets/img/high-temperature.png')),
                        Text(
                          'Hissedilen Sıcaklık: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            '$feels_like°',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
