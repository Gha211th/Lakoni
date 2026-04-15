import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/font/reponsive_font.dart';
import 'package:my_app/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lakoni.",
                  style: TextStyle(
                    fontSize: ResponsiveFont.getFontSizeForSplashTitle(context),
                    fontFamily: 'haas',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  '"Nggawe urip luwih ketata"',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'haas',
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 90,
            child: Center(
              child: Text(
                "Please Wait For A Second",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'haas',
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
