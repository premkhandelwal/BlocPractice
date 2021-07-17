import 'package:bloc_practice/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_practice/presentation/screens/home_screen.dart';
import 'package:bloc_practice/presentation/screens/second_screen.dart';
import 'package:bloc_practice/presentation/screens/third_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
              color: Colors.blueAccent,
              title: 'First Page',
            ));
      case "/second":
        return MaterialPageRoute(
            builder: (_) => SecondScreen(
              color: Colors.greenAccent,
              title: 'Second Page',
            ));
      case "/third":
        return MaterialPageRoute(
            builder: (_) => ThirdScreen(
              color: Colors.amberAccent,
              title: 'Third Page',
            ));
      default:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  color: Colors.blueAccent,
                  title: 'First Page',
                ));
    }
  }
}
