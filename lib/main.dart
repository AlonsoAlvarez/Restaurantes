import 'package:flutter/material.dart';
import 'package:restauranes/models/restaurant.dart';
import 'package:restauranes/pages/restaurants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurantes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageRestaurants()
    );
  }
}
