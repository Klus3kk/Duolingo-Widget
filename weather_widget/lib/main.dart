import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _weatherData = {};
  String _errorMessage = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    try {
      var interfaces = await NetworkInterface.list();
      var internetAddress = interfaces[0].addresses[0];
      String ipAddress = internetAddress.address;

      final response = await http.get(Uri.parse(
          'https://api.ipgeolocation.io/ipgeo?apiKey=[YOUR_API_KEY]&ip=$ipAddress&fields=city,country_name')); // Replace [YOUR_API_KEY] with your actual API key

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String locationName = "${data['city']}, ${data['country_name']}";

        final yrResponse = await http.get(Uri.parse(
            'https://www.yr.no/en/forecast/daily-table/$locationName'));

        if (yrResponse.statusCode == 200) {
          // Parse Yr.no response here (similar to previous code snippets)
        } else {
          throw Exception(
              'Failed to load weather data (Error ${yrResponse.statusCode})');
        }
      } else {
        throw Exception('Failed to get location (Error ${response.statusCode})');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Widget'),
        ),
        body: _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage))
            : _weatherData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_weatherData.containsKey('temperature'))
                          Text(
                            'Temperature: ${_weatherData['temperature']}',
                            style: TextStyle(fontSize: 24),
                          ),
                        if (_weatherData.containsKey('condition'))
                          Text(
                            'Condition: ${_weatherData['condition']}',
                            style: TextStyle(fontSize: 24),
                          ),
                        // Display other extracted weather data here
                      ],
                    ),
                  ),
      ),
    );
  }
}

