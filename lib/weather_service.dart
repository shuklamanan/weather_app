import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/weather_model.dart';
import 'package:http/http.dart' as http;

class weatherservice {
  static const base_url = "http://api.openweathermap.org/data/2.5/weather";
  final String apikey;

  weatherservice({required this.apikey});
  Future<weather> getweather(String cityname) async {
    final response = await http
        .get(Uri.parse('$base_url?q=$cityname&appid=$apikey&units=matric'));

    if (response.statusCode == 200) {
      return weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load data');
    }
  }

  Future<String> getcityname() async {
    LocationPermission permission =
        await Geolocator.checkPermission(); //get permisiion from user
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch current location from user
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //convert that location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract city name from first placemark
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
