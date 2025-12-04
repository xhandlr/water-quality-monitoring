import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import 'package:aurix/features/auth/pages/splash_screen.dart';
import 'package:aurix/features/auth/pages/login_page.dart';
import 'package:aurix/features/monitoring/pages/main_navigation.dart';
import 'package:aurix/features/monitoring/pages/settings_page.dart';
import 'package:aurix/features/monitoring/pages/sensor_detail_page.dart';
import 'package:aurix/features/monitoring/models/sensor_reading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Quality Monitoring',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
          case '/home':
          case '/dashboard':
            return MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            );
          case '/settings':
            return MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            );
          case '/sensor-detail':
            final reading = settings.arguments as SensorReading;
            return MaterialPageRoute(
              builder: (context) => SensorDetailPage(reading: reading),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            );
        }
      },
    );
  }
}


