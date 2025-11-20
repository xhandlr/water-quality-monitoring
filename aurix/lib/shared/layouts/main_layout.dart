import 'package:flutter/material.dart';

/// Layout principal con AppBar y navegación inferior
class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final int currentIndex;
  final Function(int)? onTabChanged;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    this.currentIndex = 0,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Water Quality\nMonitoring',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to home
              },
            ),
            ListTile(
              leading: const Icon(Icons.water),
              title: const Text('Monitoreo'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to monitoring
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
      body: child, // Como {children} en React
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Análisis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
