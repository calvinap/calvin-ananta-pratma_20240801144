import 'package:flutter/material.dart';
import 'profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum Flutter Layout',
      theme: ThemeData(
        // Karena digit terakhir NIM 7 (ganjil), menggunakan Colors.tealAccent[100]
        scaffoldBackgroundColor: Colors.tealAccent[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfileCard(
          nama: "Mochamad Ardiansyah",
          nim: "20240801097",
          hobi: "Mobile Gaming & Programming",
          skorAktivitas: 147, // Hasil perhitungan skor aktivitas (97 + 50)
        ),
      ),
    );
  }
}