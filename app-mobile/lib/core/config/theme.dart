import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF009EE3);     
  static const Color secondary = Color(0xFF64B5F6);   
  
  // Accent/tertiary
  static const Color accent = Color(0xFF42A5F5);
  
  // Background
  static const Color background = Color(0xFFF0F9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color navBarSelectedBackground = Color(0xFFEFF6FF);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color iconUnselected = Color(0xFF9E9E9E);
  static const Color textWhite = Colors.white;

  // General Colors
  static const Color white = Colors.white;
  static const Color shadow = Color(0x1A000000); // Colors.black with 0.1 opacity

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);

  // Dashboard Gradient
  static const Color gradientStart = Color(0xFF172C30);
  static const Color gradientMiddle = Color(0xFF0B1D35);
  static const Color gradientEnd = Color(0xFF092E4B);
  
  // Dashboard Tags
  static const Color tagBackground = Color(0xFF224560);
  static const Color tagBorder = Color(0xFF2E4B64);

  // Sensor Status Colors
  // Normal
  static const Color statusNormalIcon = Color(0xFF79BF19);
  static const Color statusNormalBg = Color(0xFFF0FDF4);
  static const Color statusNormalBorder = Color(0xFFD5FAE2);
  static const Color statusNormalDashboardBg = Color(0xFF113F3C);

  // Warning
  static const Color statusWarningIcon = Color(0xFFFBBF24);
  static const Color statusWarningBg = Color(0xFFFFFBEB);
  static const Color statusWarningBorder = Color(0xFFFDE68A);
  static const Color statusWarningDashboardBg = Color(0xFF3A372C);

  // Critical
  static const Color statusCriticalIcon = Color(0xFFE2696C);
  static const Color statusCriticalBg = Color(0xFFFEF2F2);
  static const Color statusCriticalBorder = Color(0xFFFFCDD2);
  static const Color statusCriticalDashboardBg = Color(0xFF3F1D22);
  
  // Specific Sensor Colors
  static const Color turbidezCritical = Color(0xFFF15858);

  // Conductivity (Orange)
  static const Color conductivityIcon = Color(0xFFF57C00);
  static const Color conductivityBg = Color(0xFFFFF3E0);
  static const Color conductivityBorder = Color(0xFFFFE0B2);

  // Flow (Celeste/Light Blue)
  static const Color flowIcon = Color(0xFF009EE3);
  static const Color flowBg = Color(0xFFE1F5FE);
  static const Color flowBorder = Color(0xFFB3E5FC);

  // Device Colors
  static const Color deviceOnline = Color(0xFF84CC16);
  static const Color deviceOnlineBg = Color(0xFFF0FDF4);
  static const Color deviceOffline = Color(0xFF9CA3AF); 
  static const Color deviceOfflineIcon = Color(0xFF9CA3AF);
  static const Color deviceOfflineBorder = Color(0xFFD1D5DB); 
  static const Color deviceOfflineBg = Color(0xFFE5E7EB);
  
  static const Color deviceBadgeBg = Colors.black;
  static const Color deviceBadgeText = Colors.white;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      // Títulos Grandes (Dashboard, Valores de Sensores)
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        height: 1.0,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w800, // ExtraBold
        color: AppColors.textPrimary,
      ),
      // Subtítulos de Sección
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
      ),
      // Nombres de Sensores / Títulos de Tarjetas
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.textSecondary,
      ),
      // Texto secundario / Unidades
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.textSecondary,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surface,
    ),
    useMaterial3: true,
    
    // Personalizar AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    
    // Personalizar NavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.iconUnselected,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Personalizar botones
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
