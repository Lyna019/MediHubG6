import 'package:flutter/material.dart';
import 'getstarted.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds, then navigate to the GetStartedScreen
    Timer(
      Duration(seconds: 7),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => getstarted()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lg.png', width: 250, height: 250),
            SizedBox(height: 20),
             Text(
          'MediHub        ',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 25, 25, 112), // Midnight Blue
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Equip For Life ',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Midnight Blue
          ),
          textAlign: TextAlign.center,
        ),
          ],
        ),
      ),
    );
  }
}
