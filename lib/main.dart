import 'package:flutter/material.dart';
import 'course_provider.dart'; // Import file yang baru dibuat

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
      home: Tahap5Page(),
    );
  }
}

class Tahap5Page extends StatefulWidget {
  const Tahap5Page({super.key});

  @override
  State<Tahap5Page> createState() => _Tahap5PageState();
}

class _Tahap5PageState extends State<Tahap5Page> {
  // Inisiasi ChangeNotifier secara manual untuk sementara (Sebelum pakai package Provider di Tahap 6)
  final CourseProvider courseProvider = CourseProvider();

  @override
  void dispose() {
    courseProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5: ChangeNotifier'),
        backgroundColor: Colors.indigo,
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

            // ListenableBuilder mendengarkan perubahan dari ChangeNotifier (bawaan standar Flutter)
            ListenableBuilder(
              listenable: courseProvider,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.indigo.shade50,
                  child: Text(
                    'Total Favorit: ${courseProvider.favorites.length}\n'
                        'ID Favorit: ${courseProvider.favorites.join(", ")}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Memanggil method yang ada di dalam class CourseProvider
                courseProvider.toggleFavorite('MOB01');
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Toggle Favorit MOB01'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
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