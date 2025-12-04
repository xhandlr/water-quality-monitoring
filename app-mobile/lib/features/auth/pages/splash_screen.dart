import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aurix/core/config/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    // Animación de progreso más rápida y fluida (2 segundos total)
    const totalDuration = 2000; // 2 segundos
    const steps = 50; // Menos pasos para más fluidez
    const delayPerStep = totalDuration ~/ steps; // ~40ms por paso

    for (int i = 0; i <= steps; i++) {
      await Future.delayed(Duration(milliseconds: delayPerStep));
      if (mounted) {
        setState(() {
          _progress = i / steps;
        });
      }
    }

    // Pequeña pausa para que se vea el 100% completo
    await Future.delayed(const Duration(milliseconds: 300));

    // Navegar a login después de cargar
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Espacio superior
            Spacer(flex: 1),

            // Logo/Imagen responsivo
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/loading.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.water_drop,
                      size: 120,
                      color: AppColors.primary,
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              'Aurix',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            SizedBox(height: 10),

            // Espacio antes de la barra
            Spacer(flex: 1),

            // Barra de progreso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue, // O AppColors.primary
                    ),
                    minHeight: 6,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
