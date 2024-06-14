import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/main_screen.dart';
import 'package:flutter_application_3/utils/location.dart';
import 'package:flutter_application_3/utils/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;
  bool isLoading = true;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData?.getCurrentLocation();

    if (locationData?.latitude == null || locationData?.longitude == null) {
      print("Konum bilgileri gelmiyor.");
    } else {
      print("latitude:" + locationData!.latitude.toString());
      print("longitude:" + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData!);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("Api den sıcaklık veya durum bilgisi boş dönüyor.");
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  weatherData: weatherData,
                )));
  }

  @override
  void initState() {
    super.initState();
    checkpermission_location();
  }

  checkpermission_location() async {
    if (await Permission.location.request().isGranted) {
      getWeatherData();
    } else {
      showToast("Konum izni sağlayın.", position: ToastPosition.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.blue]),
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.orange,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
