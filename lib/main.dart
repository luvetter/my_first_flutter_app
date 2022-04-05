import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const String kHelloWorld = 'Hello World';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo's",
      home: MyHomePage(title: "Todo's"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(kHelloWorld),
      ),
    );
  }
}
