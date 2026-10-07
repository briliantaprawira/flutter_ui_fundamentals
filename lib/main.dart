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
      home: Tahap2Page(),
    );
  }
}

// 1. PARENT WIDGET: Pemilik State (State Owner)
class Tahap2Page extends StatefulWidget {
  const Tahap2Page({super.key});

  @override
  State<Tahap2Page> createState() => _Tahap2PageState();
}

class _Tahap2PageState extends State<Tahap2Page> {
  // Shared State: Data favorit disimpan di Parent
  int _favoriteCount = 0;

  // Fungsi untuk mengubah state
  void _tambahFavorit() {
    setState(() {
      _favoriteCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2: Masalah setState'),
        backgroundColor: Colors.redAccent,
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

            // Melempar state ke Child 1
            FavoriteSummaryWidget(count: _favoriteCount),
            const Divider(height: 40, thickness: 2),

            // Melempar state DAN callback ke Child 2
            CourseListWidget(onFavoriteToggled: _tambahFavorit),
          ],
        ),
      ),
    );
  }
}

// 2. CHILD 1: Hanya Menerima Data
class FavoriteSummaryWidget extends StatelessWidget {
  final int count; // Menerima data dari Parent

  const FavoriteSummaryWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.shade50,
      child: Text(
        'Total Course Favorit: $count',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// 3. CHILD 2: Menerima Callback untuk dilempar lagi (Prop Drilling)
class CourseListWidget extends StatelessWidget {
  final VoidCallback onFavoriteToggled; // Menerima callback dari Parent

  const CourseListWidget({super.key, required this.onFavoriteToggled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daftar Course:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        // Melempar callback lagi ke Grandchild (Cucu)
        CourseCardWidget(courseName: 'Dart Fundamentals', onFavoriteToggled: onFavoriteToggled),
        CourseCardWidget(courseName: 'Flutter UI', onFavoriteToggled: onFavoriteToggled),
      ],
    );
  }
}

// 4. GRANDCHILD: Widget terdalam yang sebenarnya memicu aksi
class CourseCardWidget extends StatelessWidget {
  final String courseName;
  final VoidCallback onFavoriteToggled; // Menerima callback dari Parent-nya (CourseListWidget)

  const CourseCardWidget({super.key, required this.courseName, required this.onFavoriteToggled});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(courseName),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
          onPressed: onFavoriteToggled, // Memicu callback yang akan berantai memanggil _tambahFavorit di Tahap2Page
        ),
      ),
    );
  }
}