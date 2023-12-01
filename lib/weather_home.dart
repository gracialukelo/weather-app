import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory wf = WeatherFactory('2873eaa636b2e3b6fd0fbcaa9917a808');
  Weather? weather;
  String city = "Dublin";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    queryWeather();
  }

  void _handleTextField() {
    setState(() {
      city = _controller.text;
    });
  }

  void queryWeather() async {
    try {
      final currentWeather = await wf.currentWeatherByCityName(city);
      setState(() {
        weather = currentWeather;
        debugPrint(weather.toString());
      });
    } catch (e) {
      debugPrint("Die Verbindung ist nicht verfügbar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget inputAndButtonArea = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _controller,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Insert City'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _handleTextField();
                  queryWeather();
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

    Widget mainContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${weather?.areaName}, ${weather?.weatherDescription}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Center(
            child: Text(
          "${weather?.tempMax.toString().substring(0, 2) ?? ""}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 100,
            fontWeight: FontWeight.normal,
          ),
        )),
      ],
    );

    Widget backroundContent = SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WeatherScene.values[1].getWeather(),
    );

    return Scaffold(
      body: Stack(
        children: [
          backroundContent,
          mainContent,
          inputAndButtonArea,
        ],
      ),
    );
  }
}
