import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<WeatherModel> weather = [];
  final TextEditingController _controller = TextEditingController();
  String city = "Düsseldorf";
  String api = "2873eaa636b2e3b6fd0fbcaa9917a808";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api');

    try {
      final http.Response response = await http.get(url);
      final jsonResponse = jsonDecode(response.body);

      setState(() {
        if (jsonResponse.runtimeType == List) {
          weather = (jsonResponse as List)
              .map((val) => WeatherModel.fromJson(val))
              .toList();
        } else {
          weather = [WeatherModel.fromJson(jsonResponse)];
        }
      });
    } catch (e) {
      debugPrint("Die Verbindung ist nicht verfügbar: $e");
    }
  }

  void _handleTextField() {
    setState(() {
      city = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundContent(),
          _buildMainContent(),
          _buildInputAndButtonArea(),
        ],
      ),
    );
  }

  Widget _buildInputAndButtonArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(107, 255, 255, 255),
                Color.fromARGB(134, 255, 193, 7),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Insert City',
                        hintStyle: TextStyle(color: Colors.white)),
                    onSubmitted: (value) {
                      _handleTextField();
                      _fetchWeather();
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: const Color.fromARGB(105, 255, 255, 255),
                onPressed: () {
                  _handleTextField();
                  _fetchWeather();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather.isNotEmpty ? weather[0].name : "N/A",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Center(
          child: Text(
            "${_getRoundedTemperature()}°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          weather.isNotEmpty ? weather[0].weather[0].description : "N/A",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTemperatureText(
                "Min",
                weather.isNotEmpty
                    ? (weather[0].main.tempMin - 273.15).round()
                    : 0),
            const SizedBox(
              width: 10,
            ),
            _buildTemperatureText(
                "Max",
                weather.isNotEmpty
                    ? (weather[0].main.tempMax - 273.15).round()
                    : 0),
          ],
        ),
      ],
    );
  }

  Widget _buildBackgroundContent() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WeatherScene.values[1].getWeather(),
    );
  }

  Widget _buildTemperatureText(String label, int temperature) {
    return Text(
      "$label: $temperature°",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  int _getRoundedTemperature() {
    if (weather.isNotEmpty) {
      return (weather[0].main.feelsLike - 273.15).round();
    } else {
      return 0;
    }
  }
}
