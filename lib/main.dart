import 'package:flutter/material.dart';
import 'models/course.dart'; // Import model yang baru dibuat

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
      home: Tahap8Page(),
    );
  }
}

class Tahap8Page extends StatelessWidget {
  const Tahap8Page({super.key});

  @override
  Widget build(BuildContext context) {
    // TAHAP 8: Simulasi data mentah yang biasanya didapat dari file JSON atau API
    final Map<String, dynamic> rawJsonData = {
      "code": "MOB08",
      "title": "State Management Architecture",
      "credits": 3,
      "status": "Active"
    };

    // Mengubah JSON (Map) menjadi Object Course menggunakan factory fromJson
    final Course parsedCourse = Course.fromJson(rawJsonData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 8: Model Course'),
        backgroundColor: Colors.blueGrey,
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
            const SizedBox(height: 30),

            const Text(
              'Data Hasil Parsing JSON ke Object Model:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Menampilkan data yang sudah menjadi Object Course
            Card(
              elevation: 4,
              color: Colors.blueGrey.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kita tidak lagi memanggil parsedCourse['code'], melainkan langsung menggunakan properti .code
                    Text('Kode: ${parsedCourse.code}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Judul: ${parsedCourse.title}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('SKS: ${parsedCourse.credits}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('Status: ${parsedCourse.status}', style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}