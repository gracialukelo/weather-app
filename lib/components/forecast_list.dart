import 'package:flutter/material.dart';

class ForcastList extends StatelessWidget {
  final String weatherList;
  final IconData icon;
  final String day;

  const ForcastList(
      {super.key,
      required this.weatherList,
      required this.icon,
      required this.day});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        day,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      trailing: Text(
        "$weatherList°",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
