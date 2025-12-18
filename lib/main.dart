import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const LifeTimeApp());
}

class LifeTimeApp extends StatelessWidget {
  const LifeTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeTime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
