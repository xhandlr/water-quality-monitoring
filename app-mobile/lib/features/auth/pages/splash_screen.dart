import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:aurix/core/config/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double _progress = 0.0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _startLoading();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startLoading() async {
    // Animación de progreso más rápida y fluida (2.5 segundos total)
    const totalDuration = 2500;
    const steps = 60;
    const delayPerStep = totalDuration ~/ steps;

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
    // Gradiente animado que se vuelve más celeste con el progreso
    final gradientProgress = _progress * 0.3; // Máximo 30% de cambio

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF102332), // Base oscuro abajo
              Color.lerp(
                const Color(0xFF07476C), // Azul oscuro inicial arriba
                const Color(0xFF0B5A8A), // Más celeste con la carga
                gradientProgress,
              )!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo Aurix con animación de pulso
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_pulseController.value * 0.05),
                    child: Image.asset(
                      'assets/icon/aurix_icon.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.water_drop,
                          size: 100,
                          color: Colors.white,
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Nombre Aurix
              Text(
                'Aurix',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Water Quality Monitoring',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1.5,
                ),
              ),

              const Spacer(flex: 2),

              // Indicador circular de progreso
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Círculo de fondo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    // Indicador circular con gradiente
                    CustomPaint(
                      size: const Size(120, 120),
                      painter: CircularGradientProgressPainter(
                        progress: _progress,
                        startColor: AppColors.statusNormalIcon,
                        endColor: AppColors.primary,
                      ),
                    ),
                    // Porcentaje
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(_progress * 100).toInt()}%',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Cargando',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter para el indicador circular con gradiente
class CircularGradientProgressPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;

  CircularGradientProgressPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 8.0;

    // Dibuja el arco con gradiente
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    final sweepAngle = 2 * math.pi * progress;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Crear gradiente sweep más simple y seguro
    if (progress > 0) {
      final gradient = SweepGradient(
        colors: [startColor, endColor, startColor],
        stops: const [0.0, 0.5, 1.0],
        transform: const GradientRotation(-math.pi / 2),
      );

      paint.shader = gradient.createShader(rect);

      canvas.drawArc(
        rect,
        -math.pi / 2,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularGradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
