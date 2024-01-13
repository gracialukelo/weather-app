import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/weather_view_model.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: Consumer<WeatherViewModel>(
        builder: (context, provider, child) => Scaffold(
          body: Stack(
            children: [
              _BackgroundContent(),
              _MainContent(),
              _InputForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WeatherScene.values[1].getWeather(),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          provider.weather.isNotEmpty ? provider.weather[0].name : "N/A",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Center(
          child: Text(
            "${provider.getRoundedTemperature()}°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          provider.weather.isNotEmpty
              ? provider.weather[0].weather[0].description
              : "N/A",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TemperatureText(
              label: "Min",
              temperature: provider.weather.isNotEmpty
                  ? (provider.weather[0].main.tempMin - 273.15).round()
                  : 0,
            ),
            const SizedBox(
              width: 10,
            ),
            _TemperatureText(
              label: "Max",
              temperature: provider.weather.isNotEmpty
                  ? (provider.weather[0].main.tempMax - 273.15).round()
                  : 0,
            ),
          ],
        ),
      ],
    );
  }
}

class _InputForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(107, 255, 255, 255),
                Color.fromARGB(133, 192, 195, 119),
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
                    controller: provider.controller,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Insert City',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    onSubmitted: (value) {
                      provider.handleTextField();
                      provider.fetchWeather();
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: const Color.fromARGB(105, 255, 255, 255),
                onPressed: () {
                  provider.handleTextField();
                  provider.fetchWeather();
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
}

class _TemperatureText extends StatelessWidget {
  final String label;
  final int temperature;

  const _TemperatureText({
    required this.label,
    required this.temperature,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label: $temperature°",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
