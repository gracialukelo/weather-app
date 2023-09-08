import 'package:flutter/material.dart';
import 'package:weather_app/Pages/weather_home.dart';

void main() {
  runApp(const MyApp());
}

//'2873eaa636b2e3b6fd0fbcaa9917a808'

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}
