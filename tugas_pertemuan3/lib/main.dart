import 'package:flutter/material.dart';
import 'profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // NIM Mahasiswa: 20240801144 (digit terakhir = 4 -> Genap)
  static const String nimMahasiswa = '20240801144';

  @override
  Widget build(BuildContext context) {
    final int digitTerakhir =
        int.parse(nimMahasiswa[nimMahasiswa.length - 1]);
    final bool isGenap = digitTerakhir % 2 == 0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Layout Flutter',
      theme: ThemeData(
        // Digit terakhir NIM genap (4) -> Colors.amber[100]
        // Digit terakhir NIM ganjil    -> Colors.tealAccent[100]
        scaffoldBackgroundColor:
            isGenap ? Colors.amber[100] : Colors.tealAccent[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String nim = MyApp.nimMahasiswa;

    // Formula Skor Aktivitas: (2 digit terakhir NIM) + 50
    // Untuk NIM 20240801144 -> 44 + 50 = 94
    final int duaDigitTerakhir = int.parse(nim.substring(nim.length - 2));
    final int skorAktivitas = duaDigitTerakhir + 50;

    return Scaffold(
      body: Center(
        child: ProfileCard(
          nama: 'Calvin', // Silakan ubah sesuai nama lengkap Anda
          nim: nim,
          hobi: 'Coding & Membaca', // Silakan ubah sesuai hobi Anda
          skorAktivitas: skorAktivitas,
        ),
      ),
    );
  }
}
