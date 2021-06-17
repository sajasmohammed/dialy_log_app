import 'package:flutter/material.dart';
import 'package:resetapp/constants.dart';
import 'package:resetapp/screen/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat-Regular',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            color: primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat-Regular',
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: white,
            fontFamily: 'Montserrat-Regular',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: white,
            fontFamily: 'Montserrat-Regular',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat-Regular',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
