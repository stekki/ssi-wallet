import 'package:flutter/material.dart';
import 'package:frontend/routes/navigation_helper.dart';

void main() {
  NavigationHelper.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: NavigationHelper.router,
    );
  }
}
