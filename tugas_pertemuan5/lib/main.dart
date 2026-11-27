import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pencatatan Stok Barang',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const StokBarangPage(),
    );
  }
}

class StokBarangPage extends StatefulWidget {
  const StokBarangPage({super.key});

  // Identitas Mahasiswa:
  // Nama : Calvin Ananta Pratama -> Inisial nama depan = 'C'
  // NIM  : 20240801144 (Genap)   -> 2 angka terakhir NIM = '44'
  static const String inisialNamaDepan = 'C';
  static const String nimMahasiswa = '20240801144';
  static const String kodeNimSuffix = '44';
  static const int minDigitKodeBarang = 6;

  @override
  State<StokBarangPage> createState() => _StokBarangPageState();
}

class _StokBarangPageState extends State<StokBarangPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _tanggalMasukController = TextEditingController();
  final TextEditingController _tanggalKeluarController =
      TextEditingController();
  final TextEditingController _kodeBarangController = TextEditingController();
  final TextEditingController _jumlahStokController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _namaBarangController.dispose();
    _tanggalMasukController.dispose();
    _tanggalKeluarController.dispose();
    _kodeBarangController.dispose();
    _jumlahStokController.dispose();
    super.dispose();
  }

  void _kosongkanForm() {
    _formKey.currentState?.reset();
    _namaBarangController.clear();
    _tanggalMasukController.clear();
    _tanggalKeluarController.clear();
    _kodeBarangController.clear();
    _jumlahStokController.clear();
  }

  Future<void> _simpanBarang() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String namaBarang = _namaBarangController.text.trim();
      final String tanggalMasuk = _tanggalMasukController.text.trim();
      final String tanggalKeluar = _tanggalKeluarController.text.trim();
      final int kodeBarang = int.parse(_kodeBarangController.text.trim());
      final int jumlahStok = int.parse(_jumlahStokController.text.trim());

      await FirebaseFirestore.instance.collection('stok_barang').add({
        'nama_barang': namaBarang,
        'tanggal_masuk': tanggalMasuk,
        'tanggal_keluar': tanggalKeluar,
        'kode_barang': kodeBarang,
        'jumlah_stok': jumlahStok,
        'waktu': FieldValue.serverTimestamp(),
      });

      _kosongkanForm();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data stok barang berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Stok Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Nama Barang (inisial Nama Depan Mahasiswa: C)
              TextFormField(
                controller: _namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  hintText: 'Contoh: C - Charger Laptop',
                  helperText:
                      'Wajib diawali inisial nama depan (${StokBarangPage.inisialNamaDepan})',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final String trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Nama Barang wajib diisi';
                  }
                  if (!trimmed.toUpperCase().startsWith(
                        StokBarangPage.inisialNamaDepan,
                      )) {
                    return 'Nama Barang harus diawali inisial "${StokBarangPage.inisialNamaDepan}"';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. Tanggal Masuk Barang
              TextFormField(
                controller: _tanggalMasukController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Masuk Barang',
                  hintText: 'Contoh: 27-11-2026',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal Masuk Barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Tanggal Keluar Barang
              TextFormField(
                controller: _tanggalKeluarController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Keluar Barang',
                  hintText: 'Contoh: 30-11-2026',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal Keluar Barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 4. Kode Barang (Min 6 angka, 2 angka terakhir NIM Genap: 44)
              TextFormField(
                controller: _kodeBarangController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kode Barang',
                  hintText: 'Contoh: 100044',
                  helperText:
                      'Min. 6 angka & diakhiri ${StokBarangPage.kodeNimSuffix} (2 angka terakhir NIM genap: ${StokBarangPage.nimMahasiswa})',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final String trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Kode Barang wajib diisi';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(trimmed) ||
                      int.tryParse(trimmed) == null) {
                    return 'Kode Barang harus berupa angka bulat';
                  }
                  if (trimmed.length < StokBarangPage.minDigitKodeBarang) {
                    return 'Kode Barang minimal 6 angka';
                  }
                  if (!trimmed.endsWith(StokBarangPage.kodeNimSuffix)) {
                    return 'Kode Barang harus diakhiri ${StokBarangPage.kodeNimSuffix} (2 angka terakhir NIM genap)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5. Jumlah Stok (Integer, tidak boleh negatif)
              TextFormField(
                controller: _jumlahStokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Stok',
                  hintText: 'Contoh: 25',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final String trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Jumlah Stok wajib diisi';
                  }
                  final int? stok = int.tryParse(trimmed);
                  if (stok == null) {
                    return 'Jumlah Stok harus berupa angka bulat';
                  }
                  if (stok < 0) {
                    return 'Jumlah Stok tidak boleh negatif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simpanBarang,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan Barang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
