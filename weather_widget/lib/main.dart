import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherWebView(),
    );
  }
}

class WeatherWebView extends StatefulWidget {
  const WeatherWebView({Key? key}) : super(key: key);

  @override
  _WeatherWebViewState createState() => _WeatherWebViewState();
}

class _WeatherWebViewState extends State<WeatherWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.yr.no/en/content/1-72837/card.html?mode=dark'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Widget'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
