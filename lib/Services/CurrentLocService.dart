import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/Model/CurrentLocModel.dart';

Future<CurrentLoc> getCurrentWeatherData() async {
  final apiKey = 'c0dbb6f1794640eeabf103014222805';
  final position = await Geolocator.getCurrentPosition();
  final latitude = position.latitude;
  final longitude = position.longitude;

  final permissionStatus = await Permission.location.status;
  if (permissionStatus == PermissionStatus.granted) {
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude&aqi=no');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return CurrentLoc.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  } else {
    throw Exception('Location permission not granted');
  }
}

