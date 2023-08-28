import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        fontFamily: 'regular',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0,),
      ),
      home: const HomeScreen(),
    );
  }
}
