import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_pertemuan5/main.dart';

void main() {
  testWidgets('Form menampilkan 5 field input dan memvalidasi aturan NIM', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Pastikan 5 TextFormField dan tombol Simpan Barang tampil
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.text('Simpan Barang'), findsOneWidget);

    // Tekan Simpan Barang saat kosong -> semua field wajib diisi
    await tester.tap(find.text('Simpan Barang'));
    await tester.pump();

    expect(find.text('Nama Barang wajib diisi'), findsOneWidget);
    expect(find.text('Tanggal Masuk Barang wajib diisi'), findsOneWidget);
    expect(find.text('Tanggal Keluar Barang wajib diisi'), findsOneWidget);
    expect(find.text('Kode Barang wajib diisi'), findsOneWidget);
    expect(find.text('Jumlah Stok wajib diisi'), findsOneWidget);

    // Uji validasi inisial, kode barang (min 6 & akhiran 44), dan stok negatif
    await tester.enterText(find.byType(TextFormField).at(0), 'Laptop');
    await tester.enterText(find.byType(TextFormField).at(1), '27-11-2026');
    await tester.enterText(find.byType(TextFormField).at(2), '30-11-2026');
    await tester.enterText(find.byType(TextFormField).at(3), '123456');
    await tester.enterText(find.byType(TextFormField).at(4), '-5');

    await tester.tap(find.text('Simpan Barang'));
    await tester.pump();

    expect(
      find.text('Nama Barang harus diawali inisial "C"'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Kode Barang harus diakhiri 44 (2 angka terakhir NIM genap)',
      ),
      findsOneWidget,
    );
    expect(find.text('Jumlah Stok tidak boleh negatif'), findsOneWidget);
  });
}
