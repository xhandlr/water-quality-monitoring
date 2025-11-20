import 'package:flutter/material.dart';
import '../layouts/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usar el layout es como <Layout><HomePage /></Layout> en React
    return MainLayout(
      title: 'Inicio',
      currentIndex: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Monitoreo de Calidad del Agua',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to monitoring page
              },
              child: const Text('Ver Datos en Tiempo Real'),
            ),
          ],
        ),
      ),
    );
  }
}
