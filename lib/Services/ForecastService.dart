import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Constants/Constants.dart';
import 'package:weather_app/Model/ForecastModel.dart';

Future<FiveDays> getCurrentFiveDaysData() async {
  const apiKey = AppConstants.apikey;
  final position = await Geolocator.getCurrentPosition();
  final latitude = position.latitude;
  final longitude = position.longitude;
    final url = Uri.parse('http://api.weatherapi.com/v1/forecast.json?days=5&aqi=no&alerts=no&key=$apiKey&q=$latitude,$longitude');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return FiveDays.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
