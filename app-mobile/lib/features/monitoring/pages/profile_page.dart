import 'package:flutter/material.dart';
import '../../../../core/config/theme.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/account_info_card.dart';
import '../widgets/profile/settings_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Header Background
          Container(
            height: headerHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF0B1C33), Color(0xFF0A2640)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const ProfileHeader(),
                const SizedBox(height: 24),

                // Info Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const SingleChildScrollView(
                      child: Column(
                        children: [
                          AccountInfoCard(),
                          SizedBox(height: 16),
                          SettingsCard(),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

