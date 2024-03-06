import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/navigation_helper.dart';
import 'utils/app_theme.dart';

void main() async {
  log('Starting App');
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  NavigationHelper.instance;
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp.router(
        title: 'Flutter Login Page',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: NavigationHelper.router,
      ),
    );
  }
}
