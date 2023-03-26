import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/Constants/Colors.dart';
import 'package:weather_app/Model/CurrentLocModel.dart';
import 'package:weather_app/Services/CurrentLocService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<CurrentLoc> futureWeather;
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
      });
    } else if (status == PermissionStatus.denied) {
      // Permission denied, show a message or disable functionality...
    } else {
      // Permission permanently denied, open app settings...
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
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child:
                  Lottie.asset('assets/weather.json', height: 300, width: 300),
            ),
            FutureBuilder<CurrentLoc>(
              future: futureWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final weatherData = snapshot.data!;
                  return Column(
                    children: [
                      Text('Location: '),
                      Text('${weatherData.location!.name}'),
                      Text(
                          'Condition: ${weatherData.current!.condition!.text}'),
                      Text(
                          'Temperature: ${useMetric ? weatherData.current!.tempC : weatherData.current!.tempF}${getTemperatureUnit()}'),
                      Text(
                          'Wind speed: ${useMetric ? weatherData.current!.windKph : weatherData.current!.windMph}${getWindSpeedUnit()}'),
                      Text(
                          'Precipitation: ${useMetric ? weatherData.current!.precipMm : weatherData.current!.precipIn}${getPrecipitationUnit()}'),
                      Text('Humidity: ${weatherData.current!.humidity}%'),
                      ToggleButtons(
                        children: [
                          Text("Metric"),
                          Text("Imperial"),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        isSelected: [useMetric, !useMetric],
                        selectedBorderColor: AppColors.primary_color,
                        selectedColor: AppColors.primary_color,
                        color: AppColors.primary_color,
                        constraints:
                            BoxConstraints(minWidth: 100, minHeight: 50),
                        onPressed: (index) {
                          setState(() {
                            useMetric = index == 0;
                          });
                        },
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
          ],
        ),
      ),
    );
  }
}
