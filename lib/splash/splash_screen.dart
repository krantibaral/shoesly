import 'package:flutter/material.dart';
import 'package:shoesly/constants.dart';
import 'package:shoesly/home/home_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity value

  @override
  void initState() {
    super.initState();
    // start animation after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; 
      });
    });
    // navigate to home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000), 
          pageBuilder: (_, __, ___) => const HomeView(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1), // duration of the fade-in animation
          child: Image.asset(
            'assets/Shoesly.png', 
            width: 150, 
            height: 150, 
            fit: BoxFit.contain, 
          ),
        ),
      ),
    );
  }
}
