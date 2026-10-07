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
      home: Tahap3Page(),
    );
  }
}

// PARENT WIDGET: Bertindak sebagai Single Source of Truth
class Tahap3Page extends StatefulWidget {
  const Tahap3Page({super.key});

  @override
  State<Tahap3Page> createState() => _Tahap3PageState();
}

class _Tahap3PageState extends State<Tahap3Page> {
  // Satu-satunya sumber data (Single Source of Truth)
  bool _isFavorite = false;

  // Callback untuk mengubah state di parent
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3: Lifting State Up'),
        backgroundColor: Colors.green,
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

            // Child 1: Hanya membaca state untuk menampilkan status
            StatusWidget(isFav: _isFavorite),
            const SizedBox(height: 20),

            // Child 2: Membaca state DAN menerima callback untuk mengubahnya
            CourseCard(
              isFavorite: _isFavorite,
              onFavoriteChanged: _toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

// CHILD 1
class StatusWidget extends StatelessWidget {
  final bool isFav;
  const StatusWidget({super.key, required this.isFav});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isFav ? Colors.green.shade100 : Colors.grey.shade200,
      child: Text(
        isFav ? 'Status: Mata Kuliah Difavoritkan! 💚' : 'Status: Belum Difavoritkan 🤍',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// CHILD 2
class CourseCard extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseCard({super.key, required this.isFavorite, required this.onFavoriteChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.green),
        title: const Text('State Management'),
        subtitle: const Text('Tekan ikon hati di kanan ->'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoriteChanged,
        ),
      ),
    );
  }
}