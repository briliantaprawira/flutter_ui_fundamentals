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
      home: Tahap16Page(),
    );
  }
}

// --- HALAMAN UTAMA ---
class Tahap16Page extends StatelessWidget {
  const Tahap16Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16: Hero Animation'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '$studentId - $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text('Ketuk ikon roket di bawah ini:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // TAHAP 16: Membungkus elemen dengan widget Hero
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tahap16DetailPage()),
                );
              },
              child: const Hero(
                tag: 'roket-hero', // Identitas unik yang menghubungkan kedua halaman
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(Icons.rocket_launch, size: 40, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HALAMAN DETAIL ---
class Tahap16DetailPage extends StatelessWidget {
  const Tahap16DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Hero'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TAHAP 16: Hero di halaman tujuan menangkap tag yang sama persis
            const Hero(
              tag: 'roket-hero', // Tag ini HARUS sama dengan yang ada di Halaman Utama
              child: CircleAvatar(
                radius: 120, // Ukurannya kita perbesar di halaman detail
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.rocket_launch, size: 120, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            const Text('Animasi Hero Berhasil! 🚀', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Perhatikan bagaimana ikon roket tadi bergerak membesar dari halaman sebelumnya secara mulus tanpa terputus.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}