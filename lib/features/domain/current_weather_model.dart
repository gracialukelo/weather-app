class WeatherModel {
  int maxTemp;
  String nameCity;
  String descrption;

  WeatherModel(
      {required this.maxTemp,
      required this.nameCity,
      required this.descrption});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      maxTemp: json["main"],
      nameCity: json["name"],
      descrption: json["weather"]);
}
