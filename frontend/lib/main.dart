import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/navigation_helper.dart';
import 'utils/app_theme.dart';

void main() {
  log('Starting App');
  NavigationHelper.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Login Page',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: NavigationHelper.router,
      ),
    );
  }
}
