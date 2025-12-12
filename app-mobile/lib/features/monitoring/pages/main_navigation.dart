import 'package:flutter/material.dart';
import 'package:aurix/core/config/theme.dart';
import 'dashboard_page.dart';
import 'devices_page.dart';
import 'alerts_page.dart';
import 'charts_page.dart';
import 'profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const DevicesPage(),
    const AlertsPage(),
    const ChartsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppColors.navBarSelectedBackground,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Colors.white,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.primary);
            }
            return const IconThemeData(color: Colors.grey);
          }),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: SizedBox(height: 32, width: 32, child: Icon(Icons.dashboard_outlined)),
              selectedIcon: SizedBox(height: 32, width: 32, child: Icon(Icons.dashboard)),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: SizedBox(height: 32, width: 32, child: Icon(Icons.devices_outlined)),
              selectedIcon: SizedBox(height: 32, width: 32, child: Icon(Icons.devices)),
              label: 'Dispositivos',
            ),
            NavigationDestination(
              icon: SizedBox(height: 32, width: 32, child: Icon(Icons.notifications_outlined)),
              selectedIcon: SizedBox(height: 32, width: 32, child: Icon(Icons.notifications)),
              label: 'Alertas',
            ),
            NavigationDestination(
              icon: SizedBox(height: 32, width: 32, child: Icon(Icons.show_chart)),
              selectedIcon: SizedBox(height: 32, width: 32, child: Icon(Icons.show_chart)),
              label: 'Gráficos',
            ),
            NavigationDestination(
              icon: SizedBox(height: 32, width: 32, child: Icon(Icons.person_outline)),
              selectedIcon: SizedBox(height: 32, width: 32, child: Icon(Icons.person)),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
