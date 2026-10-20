import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import package provider
import 'course_provider.dart'; // Import file provider yang kita buat di Tahap 5

const String studentName = 'Kadek Brilianta Prawira Arta';
const String studentId = '2415051013';

void main() {
  runApp(
    // TAHAP 6: Membungkus aplikasi dengan ChangeNotifierProvider
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
      home: Tahap6Page(),
    );
  }
}

// Perhatikan: Kita sekarang bisa menggunakan StatelessWidget, tidak perlu StatefulWidget!
class Tahap6Page extends StatelessWidget {
  const Tahap6Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data dari Provider yang sudah dipasang di pucuk aplikasi (main)
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 6: Provider Setup'),
        backgroundColor: Colors.teal,
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

            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.teal.shade50,
              child: Text(
                'Total Favorit dari Provider: ${courseProvider.favorites.length}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Memanggil fungsi dari Provider
                courseProvider.toggleFavorite('MOB_TEST_6');
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Uji Provider Setup'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
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