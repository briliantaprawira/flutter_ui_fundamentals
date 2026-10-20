import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';

const String studentName = 'Kadek Brilianta Prawira Arta';
const String studentId = '2415051013';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tahap7Page(),
    );
  }
}

class Tahap7Page extends StatelessWidget {
  const Tahap7Page({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('--> build() utama Tahap7Page dipanggil');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 7: watch vs read'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
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
            const SizedBox(height: 20),

            // 1. Menggunakan Consumer: Membatasi rebuild HANYA pada Container ini
            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                debugPrint('--> Consumer merender ulang teks jumlah');
                return Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.deepOrange.shade50,
                  child: Text(
                    'Total Favorit (via Consumer): ${provider.favorites.length}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // 2. Menggunakan Widget terpisah yang memakai context.watch()
            const WatcherWidget(),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // 3. Menggunakan context.read(): Memanggil aksi TANPA mendengarkan perubahan (tidak ikut ter-rebuild)
                context.read<CourseProvider>().toggleFavorite('MOB07');
              },
              icon: const Icon(Icons.touch_app),
              label: const Text('Ubah State dengan context.read()'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk menguji context.watch()
class WatcherWidget extends StatelessWidget {
  const WatcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // MENGGUNAKAN WATCH: Mendengarkan data. Jika data berubah, widget ini akan di-rebuild.
    final provider = context.watch<CourseProvider>();
    debugPrint('--> WatcherWidget merender ulang list ID');

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: Text(
        'List ID (via watch): ${provider.favorites.isEmpty ? "-" : provider.favorites.join(", ")}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}