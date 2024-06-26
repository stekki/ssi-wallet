import 'dart:developer';
import 'dart:io' show Platform;

import 'package:authn/authn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/app_theme.dart';
import 'providers/providers.dart';
import 'routes/navigation_helper.dart';

void main() async {
  log('Starting App');
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  NavigationHelper.instance;
  if (Platform.isLinux) {
    setupFromYAML('authn_cfg.yaml');
  }
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
