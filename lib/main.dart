import 'package:flutter/material.dart';

const String studentName = 'Kadek Brilianta Prawira Arta';
const String studentId = '2415051013';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tahap4Page(),
    );
  }
}

class Tahap4Page extends StatefulWidget {
  const Tahap4Page({super.key});

  @override
  State<Tahap4Page> createState() => _Tahap4PageState();
}

class _Tahap4PageState extends State<Tahap4Page> {
  // TAHAP 4: Menggunakan ValueNotifier untuk mengelola satu nilai sederhana
  final ValueNotifier<int> _favoriteCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    // Jangan lupa membuang (dispose) notifier saat widget dihancurkan untuk mencegah memory leak
    _favoriteCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pesan ini hanya akan dicetak sekali di terminal (membuktikan UI tidak direbuild total)
    debugPrint('--> build() utama Tahap4Page dijalankan');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4: ValueNotifier'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // TAHAP 4: ValueListenableBuilder akan mendengarkan perubahan pada _favoriteCount
            ValueListenableBuilder<int>(
              valueListenable: _favoriteCount,
              builder: (context, value, child) {
                // Pesan ini akan dicetak berulang kali setiap tombol ditekan
                debugPrint('--> ValueListenableBuilder merender ulang angka $value');
                return Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.amber.shade100,
                  child: Column(
                    children: [
                      const Text('Jumlah Course Favorit:', style: TextStyle(fontSize: 18)),
                      Text(
                        '$value',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.amber),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Mengubah value secara langsung, TANPA PERLU MEMANGGIL setState()
                _favoriteCount.value++;
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Nilai Favorit'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16)
              ),
            ),
          ],
        ),
      ),
    );
  }
}