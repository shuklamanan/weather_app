class weather {
  String cityname;
  final double temperature;
  final String maincondition; // sunny or cloudy

  weather(
      {required this.cityname,
      required this.temperature,
      required this.maincondition});

  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
        cityname: json['name'],
        temperature: json['main']['temp'].toDouble(),
        maincondition: json['weather'][0]['main']);
  }
}
