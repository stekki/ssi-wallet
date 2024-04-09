import 'package:flutter/material.dart';
import 'dart:async';

import '../routes/navigation_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    Future.delayed(const Duration(seconds: 3), () {
      _animationController.stop();
      NavigationHelper.instance.navigateToLanding();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
            opacity: _animation,
            child: Container(
              margin: const EdgeInsets.only(bottom: 200),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/logos/findywallet_white.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
