import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/utils/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class WeatherDisplayData {
  Icon weatherIcon;

  WeatherDisplayData({required this.weatherIcon});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double? currentTemperature;
  int? currentPressure; //basınç
  int? currentHumidity; //nem
  int? currentCondition;
  double? currentWind; //rüzgar
  double? currentFeelsLike;
  String? city;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=#YOUR_API_KEY&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentPressure = currentWeather['main']['pressure'];
        currentHumidity = currentWeather['main']['humidity'];
        currentWind = currentWeather['wind']['speed'];
        currentFeelsLike = currentWeather['main']['feels_like'];
        city = currentWeather['name'];

        //double windSpeedMetersPerSecond = 3.07;
        //double windSpeedKilometersPerHour = windSpeedMetersPerSecond / 3.6;
      } catch (e) {
        print(e);
      }
    } else {
      print("API den değer gelmiyor.");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition != null && currentCondition == '') {
      if (currentCondition! >= 801) {
        return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
            color: Colors.white,
          ),
          //weatherImage: AssetImage('');
        );
      } else {
        if (currentCondition! > 781) {
          return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            //weatherImage: AssetImage('');
          );
        } else {
          if (currentCondition! > 622) {
            return WeatherDisplayData(
              weatherIcon: Icon(
                FontAwesomeIcons.smog,
                size: 75.0,
                color: Colors.white,
              ),
              //weatherImage: AssetImage('');
            );
          } else {
            if (currentCondition! > 531) {
              return WeatherDisplayData(
                weatherIcon: Icon(
                  FontAwesomeIcons.snowflake,
                  size: 75.0,
                  color: Colors.white,
                ),
                //weatherImage: AssetImage('');
              );
            } else {
              if (currentCondition! > 321) {
                return WeatherDisplayData(
                  weatherIcon: Icon(
                    FontAwesomeIcons.rainbow,
                    size: 75.0,
                    color: Colors.white,
                  ),
                  //weatherImage: AssetImage('');
                );
              } else {
                if (currentCondition! >= 200) {
                  return WeatherDisplayData(
                    weatherIcon: Icon(
                      FontAwesomeIcons.cloudBolt,
                      size: 75.0,
                      color: Colors.white,
                    ),
                    //weatherImage: AssetImage('');
                  );
                }
              }
            }
          }
        }
      }
    }
    var now = new DateTime.now().toLocal(); // saat ayarı iptal
    if (now.hour >= 19 && now.hour <= 7) {
      return WeatherDisplayData(
        weatherIcon: Icon(
          FontAwesomeIcons.moon,
          size: 75.0,
          color: Colors.white,
        ),
      );
    } else {
      return WeatherDisplayData(
        weatherIcon: Icon(
          FontAwesomeIcons.sun,
          size: 75.0,
          color: Colors.white,
        ),
      );
    }
  }
}
