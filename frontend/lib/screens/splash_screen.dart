import 'package:flutter/material.dart';
import 'dart:async'; // Import dart:async to use Timer
import '../routes/navigation_helper.dart'; // Make sure this path is correct

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          Duration(seconds: 1), // Duration of one cycle (fade in and fade out)
    )..repeat(
        reverse:
            true); // Automatically reverse the animation at the end of each cycle

    _animation = Tween<double>(
      begin: 0.0, // Completely transparent
      end: 1.0, // Fully visible
    ).animate(_animationController);

    // Navigate away from the splash screen after some time
    Future.delayed(Duration(seconds: 3), () {
      _animationController.stop(); // Stop the animation
      NavigationHelper.instance.navigateToLanding();
    });
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 255, 191), // Start color
              Color.fromARGB(255, 50, 103, 141), // End color
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation, // Use the animation for opacity value
            child: Container(
              margin: EdgeInsets.only(bottom: 200),
              child: Image.asset('assets/logos/findywallet_white.png'),
            ),
          ),
        ),
      ),
    );
  }
}
