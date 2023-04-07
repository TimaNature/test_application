import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_application/repository/Repository.dart';
import 'package:test_application/ui/image_list.dart';
import 'package:test_application/ui/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    late Widget nextScreen;

    Repository().isRegistered().then((value) => {
      if (value)
        {nextScreen = const ImageList()}
      else
        {nextScreen = const Registration()}
    }, onError: (error) {
      print(error);
    });

    Timer(
        const Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => nextScreen)));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(""),
      ),
    );
  }
}
