// weather_view_model.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  List<WeatherModel> weather = [];
  final TextEditingController controller = TextEditingController();
  String city = "Düsseldorf";
  String api = "2873eaa636b2e3b6fd0fbcaa9917a808";

  WeatherViewModel() {
    // Initial fetch when the ViewModel is created
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api');

    try {
      final http.Response response = await http.get(url);
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse.runtimeType == List) {
        weather = (jsonResponse as List)
            .map((val) => WeatherModel.fromJson(val))
            .toList();
      } else {
        weather = [WeatherModel.fromJson(jsonResponse)];
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Die Verbindung ist nicht verfügbar: $e");
    }
  }

  void handleTextField() {
    city = controller.text;
  }

  int getRoundedTemperature() {
    if (weather.isNotEmpty) {
      return (weather[0].main.feelsLike - 273.15).round();
    } else {
      return 0;
    }
  }
}
