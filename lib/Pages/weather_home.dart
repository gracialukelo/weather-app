import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/components/forecast_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory wf = WeatherFactory('2873eaa636b2e3b6fd0fbcaa9917a808');
  Weather? weather;
  List<Weather>? weatherList;
  String city = "Dublin";
  final TextEditingController _controller = TextEditingController();
  List<String> days = ["defaul", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];

  @override
  void initState() {
    super.initState();

    queryWeather();
    fiveDayForecast();

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
      });
    } catch (e) {
      debugPrint("Die Verbindung ist nicht verfügbar: $e");
    }
  }

  void fiveDayForecast() async {
    try {
      final currentFiveWeather = await wf.fiveDayForecastByCityName(city);
      setState(() {
        weatherList = currentFiveWeather;
      });

      debugPrint(WeatherScene.values.toString());
    } catch (e) {
      debugPrint("Die Verbindung ist nicht verfügbar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WeatherScene.values[1].getWeather(),
            
          ),
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                "${weather?.areaName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "${weather?.tempMax.toString().substring(0, 2) ?? ""}°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${weather?.weatherDescription}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(35, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        ForcastList(
                            day: weatherList != null && weatherList!.isNotEmpty
                                ? days[weatherList![1].date!.weekday]
                                : '',
                            icon: weatherList![0].weatherMain == "Clouds"
                                ? Icons.cloud
                                : Icons.sunny,
                            weatherList:
                                weatherList != null && weatherList!.isNotEmpty
                                    ? weatherList![0]
                                        .temperature
                                        .toString()
                                        .substring(0, 2)
                                    : ""),
                        ForcastList(
                            day: weatherList != null && weatherList!.isNotEmpty
                                ? days[weatherList![2].date!.weekday]
                                : '',
                            icon: weatherList![1].weatherMain == "Clouds"
                                ? Icons.cloud
                                : Icons.sunny,
                            weatherList:
                                weatherList != null && weatherList!.isNotEmpty
                                    ? weatherList![1]
                                        .tempMax
                                        .toString()
                                        .substring(0, 2)
                                    : ""),
                        ForcastList(
                            day: weatherList != null && weatherList!.isNotEmpty
                                ? days[weatherList![3].date!.weekday]
                                : '',
                            icon: weatherList![2].weatherMain == "Clouds"
                                ? Icons.cloud
                                : Icons.sunny,
                            weatherList:
                                weatherList != null && weatherList!.isNotEmpty
                                    ? weatherList![2]
                                        .tempMax
                                        .toString()
                                        .substring(0, 2)
                                    : ""),
                        ForcastList(
                            day: weatherList != null && weatherList!.isNotEmpty
                                ? days[weatherList![4].date!.weekday]
                                : '',
                            icon: weatherList![3].weatherMain == "Clouds"
                                ? Icons.cloud
                                : Icons.sunny,
                            weatherList:
                                weatherList != null && weatherList!.isNotEmpty
                                    ? weatherList![3]
                                        .tempMax
                                        .toString()
                                        .substring(0, 2)
                                    : ""),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Insert City'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _handleTextField();
                        queryWeather();
                        fiveDayForecast();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          )
        ],
      ),
    );
  }
}
