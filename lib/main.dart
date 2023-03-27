import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Constants/Colors.dart';
import 'package:weather_app/Views/Test.dart';

import 'Views/HomeScreen.dart';
import 'Views/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.primary_color,
      title: 'Phone Auth',
      home: PhoneAuthScreen(),
    );
  }
}
