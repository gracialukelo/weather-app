import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //String key = '2873eaa636b2e3b6fd0fbcaa9917a808';
  WeatherFactory wf = WeatherFactory('2873eaa636b2e3b6fd0fbcaa9917a808');
  Weather? weather; // Use Weather type instead of List<Weather>
  double lat = 55.0111;
  double lon = 15.0569;

  void queryWeather() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      weather = null; // Clear previous data
    });

    Weather currentWeather = await wf.currentWeatherByCityName("Berlin");

    setState(() {
      weather = currentWeather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WeatherScene.sunset.getWeather()),
        Center(
          child: weather != null
              ? ListTile(
                  title: Text(
                    weather!.tempMax.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : const Text('No weather data available'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(35, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                          Text("Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("20/14",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                          Text("Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("20/14",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                          Text("Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("20/14",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                          Text("Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          Text("20/14",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          queryWeather();
        },
        child: const Icon(Icons.place),
      ),
    );
  }
}


//  Scaffold(
//       body: Center(
//         child: weather != null
//             ? ListTile(
//                 title: Text(weather!.tempMax.toString()),
//               )
//             : const Text('No weather data available'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           queryWeather();
//         },
//         child: const Icon(Icons.place),
//       ),
//     );