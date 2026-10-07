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
      home: Tahap1Page(),
    );
  }
}

// TAHAP 1: Menggunakan StatefulWidget untuk mengelola Local State
class Tahap1Page extends StatefulWidget {
  const Tahap1Page({super.key});

  @override
  State<Tahap1Page> createState() => _Tahap1PageState();
}

class _Tahap1PageState extends State<Tahap1Page> {
  // Ini adalah LOCAL STATE: Data yang hanya dipakai di dalam widget ini saja
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 1: Local State'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa
            const Text(
                '$studentId - $studentName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            ),
            const SizedBox(height: 20),

            const Card(
              child: ListTile(
                leading: Icon(Icons.book, color: Colors.blue),
                title: Text('Dart Fundamentals'),
                subtitle: Text('MOB01 - 2 SKS'),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol untuk mengubah Local State
            ElevatedButton(
              onPressed: () {
                // Memanggil setState() akan memerintahkan Flutter untuk me-rebuild UI
                setState(() {
                  _showDescription = !_showDescription;
                });
              },
              child: Text(_showDescription ? 'Sembunyikan Deskripsi' : 'Tampilkan Deskripsi'),
            ),
            const SizedBox(height: 16),

            // UI yang muncul/hilang bergantung pada nilai _showDescription
            if (_showDescription)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Ini adalah deskripsi mata kuliah. \nTampilan ini dikendalikan oleh Local State menggunakan fungsi setState().',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}