import 'package:flutter/material.dart';
import 'package:to_do_list/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do List with Date',
        theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
    useMaterial3: true,
    ),
    home: const SplashPage(),
    );
}
}
