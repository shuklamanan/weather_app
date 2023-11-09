import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_service.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherservice =
      weatherservice(apikey: '0bc200f4fc5c1aaac962a113680f3317');
  weather? _weather;
  String? cityname;
  // String inputcity = _weather!.cityname;
  TextEditingController _city = TextEditingController();
  _fetchweather() async {
    (_city.text.isEmpty)
        ? cityname = await _weatherservice.getcityname()
        : cityname = _city.text.toString();

    try {
      final weather = await _weatherservice.getweather(cityname!);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getweatheranimation(String? maincondition) {
    if (maincondition == null) {
      return 'lib/assets/sunny.json';
    }
    switch (maincondition.toLowerCase()) {
      case 'fog':
        return 'lib/assets/cloud.json';
      case 'mist':
        return 'lib/assets/cloud.json';
      case 'haze':
        return 'lib/assets/cloud.json';
      case 'smoke':
        return 'lib/assets/cloud.json';
      case 'shower rain':
        return 'lib/assets/rainy.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      case 'thunderstorm':
        return 'lib/assets/thunder.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityname ?? "loading city.."),
            Lottie.asset(getweatheranimation(_weather?.maincondition)),
            Text('${_weather?.temperature} *K'),
            Text(_weather?.maincondition ?? ""),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              child: TextField(
                controller: _city,
                decoration: InputDecoration(
                    label: Text('Enter City'), border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      (_city.text.isNotEmpty)
                          ? _weather?.cityname = _city.text.toString()
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                dismissDirection: DismissDirection.down,
                                behavior: SnackBarBehavior.floating,
                                width: 200,
                                padding: const EdgeInsets.all(10),
                                backgroundColor:
                                    Color.fromARGB(255, 158, 212, 236),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                content: const Text(
                                  'Text Field is Empty',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                      _fetchweather();
                      _city.clear();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 70,
                      child: Center(child: Text('Go To')),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 7,
                              spreadRadius: 5.0,
                            ),
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 7,
                              offset: Offset(-1, -1),
                              spreadRadius: 1.0,
                            ),
                          ]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _city.clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 70,
                      child: Center(child: Text('Cancel')),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 7,
                              spreadRadius: 5.0,
                            ),
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 7,
                              offset: Offset(-1, -1),
                              spreadRadius: 1.0,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
