import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return  WeatherScene.sunset.getWeather();
  }
}
