import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final http.Client client;

  WeatherService({required this.client});

  final String apiUrl = "https://api.met.no/weatherapi/locationforecast/2.0/compact";

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final response = await client.get(Uri.parse('$apiUrl?lat=$lat&lon=$lon'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
