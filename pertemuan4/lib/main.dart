import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Profile Card',
      theme: AppTheme.lightTheme,
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  // NIM: 20240801144 -> digit terakhir d = 4
  static const int nimLastDigit = 4;

  // Perhitungan ukuran berdasarkan NIM (d = 4):
  // - Padding card       : 16 + d      = 16 + 4      = 20 px
  // - Rounded card       : 8 + d       = 8 + 4       = 12 px
  // - Tinggi tombol      : 40 + d      = 40 + 4      = 44 px
  // - Rounded tombol     : 4 + d       = 4 + 4       = 8 px
  // - Ukuran avatar      : 40 + (2*d)  = 40 + (2*4)  = 48 px
  // - Jarak nama dan NIM : 8 + d       = 8 + 4       = 12 px
  static const double cardPadding = 16.0 + nimLastDigit;
  static const double cardBorderRadius = 8.0 + nimLastDigit;
  static const double buttonHeight = 40.0 + nimLastDigit;
  static const double buttonBorderRadius = 4.0 + nimLastDigit;
  static const double avatarSize = 40.0 + (2 * nimLastDigit);
  static const double nameNimSpacing = 8.0 + nimLastDigit;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile Card'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardBorderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: avatarSize,
                      height: avatarSize,
                      child: CircleAvatar(
                        backgroundColor: colorScheme.primaryContainer,
                        foregroundColor: colorScheme.onPrimaryContainer,
                        child: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Calvin Ananta Pratama'),
                    const SizedBox(height: nameNimSpacing),
                    const Text('NIM: 20240801144'),
                    const SizedBox(height: 8),
                    const Text('Program Studi: Teknik Informatika'),
                    const SizedBox(height: 12),
                    const Text(
                      'Mahasiswa Teknik Informatika yang tertarik pada pengembangan aplikasi mobile menggunakan Flutter.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const AppButton(
                      label: 'Kunjungi GitHub Saya',
                      icon: Icons.open_in_new,
                      url: 'https://github.com/calvinap',
                      height: buttonHeight,
                      borderRadius: buttonBorderRadius,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
