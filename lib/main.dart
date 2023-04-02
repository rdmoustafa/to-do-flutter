import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/constants/directory.dart';
import 'package:to_do/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //This line is so that there is no difference between the status bar and the app bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Home(),
    );
  }
}