import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Row(
            children: [
              // Logo Aurix
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  'assets/icon/aurix_icon.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.water_drop,
                      size: 26,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  'Mi Perfil',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 28,

                  )
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF233D54),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Función de edición en desarrollo'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Profile Info
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF009EE3), width: 2),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.grey[400],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Usuario Demo',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Administrador de Campo',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
