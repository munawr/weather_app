import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/Constants/Colors.dart';
import 'package:weather_app/Model/CurrentLocModel.dart';
import 'package:weather_app/Services/CurrentLocService.dart';

import '../Model/ForecastModel.dart';
import '../Services/ForecastService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Future<CurrentLoc>? futureWeather;
   Future<FiveDays>? futureFive;
  bool useMetric = true;
  void _toggleButton(bool value) {
    setState(() {
      useMetric = value;
    });
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        futureWeather = getCurrentWeatherData();
        futureFive = getCurrentFiveDaysData();
      });
    } else if (status == PermissionStatus.denied) {
      // Permission denied
    } else {
      // Permission permanently denied
      openAppSettings();
    }
  }

  String getTemperatureUnit() {
    return useMetric ? "°C" : "°F";
  }

  String getWindSpeedUnit() {
    return useMetric ? "km/h" : "mph";
  }

  String getPrecipitationUnit() {
    return useMetric ? "mm" : "in";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App Lite'),
        backgroundColor: AppColors.primary_color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder<CurrentLoc>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final weatherData = snapshot.data!;
                    return Column(
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Card(
                          elevation: 8,
                          child: Text(
                            '${weatherData.location!.name}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Lottie.asset('assets/weather.json',
                            height: 200, width: 200),
                        const SizedBox(
                          height: 5,
                        ),
                        
                        Text(
                            '${useMetric ? weatherData.current!.tempC : weatherData.current!.tempF}${getTemperatureUnit()}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                                Text(
                          '${weatherData.current!.condition!.text}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Wind speed'),
                        Text(
                            '${useMetric ? weatherData.current!.windKph : weatherData.current!.windMph}${getWindSpeedUnit()}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Precipitation'),
                        Text(
                            '${useMetric ? weatherData.current!.precipMm : weatherData.current!.precipIn}${getPrecipitationUnit()}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Humidity'),
                        Text('${weatherData.current!.humidity}%',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ToggleButtons(
                            children: [
                              const Text("Metric"),
                              const Text("Imperial"),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            isSelected: [useMetric, !useMetric],
                            selectedBorderColor: AppColors.primary_color,
                            selectedColor: AppColors.primary_color,
                            color: AppColors.primary_color,
                            constraints: const BoxConstraints(
                                minWidth: 100, minHeight: 50),
                            onPressed: (index) {
                              setState(() {
                                useMetric = index == 0;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Forecast',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                elevation: 25,
                child: FutureBuilder<FiveDays>(
                  future: futureFive,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final forecastData = snapshot.data!;
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecastData.forecast!.forecastday!.length,
                          itemBuilder: (context, index) {
                            final forecast =
                                forecastData.forecast!.forecastday![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(forecast.date!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Image.network(
                                      'http:${forecast.day!.condition!.icon}',
                                      height: 50,
                                      width: 50),
                                  const SizedBox(height: 5),
                                  Text(forecast.day!.condition!.text!),
                                  const SizedBox(height: 5),
                                  Text(
                                      '${useMetric ? forecast.day!.maxtempC : forecast.day!.maxtempF}${getTemperatureUnit()}'),
                                  Text(
                                      '${useMetric ? forecast.day!.mintempC : forecast.day!.mintempF}${getTemperatureUnit()}'),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                       return const Align(
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
