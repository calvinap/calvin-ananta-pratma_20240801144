import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  @override
  Widget build(BuildContext context) {
    // Ekstraksi digit dari NIM (NIM: 20240801144)
    // Digit terakhir = 4, Digit ke-2 dari belakang = 4
    final int digitTerakhir =
        nim.isNotEmpty ? int.parse(nim[nim.length - 1]) : 0;
    final int digitKeduaBelakang =
        nim.length >= 2 ? int.parse(nim[nim.length - 2]) : 0;

    // Formula nilai atribut styling wajib berdasarkan digit NIM:
    // Lebar Kartu     : 320.0 + (4 * 5)   = 340.0
    // Sudut Melengkung: 12.0  + (4 * 1.5) = 18.0
    // Ukuran Logo     : 60.0  + (4 * 2)   = 68.0
    // Jarak Pemisah   : 15.0  + 4         = 19.0
    final double lebarKartu = 320.0 + (digitKeduaBelakang * 5);
    final double sudutMelengkung = 12.0 + (digitTerakhir * 1.5);
    final double ukuranLogo = 60.0 + (digitTerakhir * 2);
    final double jarakPemisah = 15.0 + digitTerakhir;

    return Container(
      width: lebarKartu,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sudutMelengkung),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header Kartu (Horizontal - Row)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sisi Kiri: FlutterLogo dalam Container berbingkai lingkaran/lengkung
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(ukuranLogo),
                  border: Border.all(
                    color: Colors.blue.shade200,
                    width: 2.0,
                  ),
                ),
                child: FlutterLogo(size: ukuranLogo),
              ),

              // Jarak Pemisah Horizontal
              SizedBox(width: jarakPemisah),

              // Sisi Kanan: Column dengan CrossAxisAlignment.start
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kartu Praktikan',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Pemisah
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(thickness: 1.5),
          ),

          // Bagian Detail Identitas (Vertikal - Column)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NIM : $nim',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Hobi : $hobi',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Skor Aktivitas : $skorAktivitas',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
