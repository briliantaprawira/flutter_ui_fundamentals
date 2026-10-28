import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<CourseProvider>().isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${course.code}'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        // TAHAP 15: Menambahkan tombol Hapus (Delete) di pojok kanan atas
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Hapus Mata Kuliah',
            onPressed: () {
              // Memanggil fungsi deleteCourse dari Provider
              context.read<CourseProvider>().deleteCourse(course);
              
              // Menutup halaman detail dan kembali ke halaman utama setelah dihapus
              Navigator.pop(context); 
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(course.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('SKS: ${course.credits}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: () {
                context.read<CourseProvider>().toggleFavorite(course.code);
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              label: Text(isFav ? 'Hapus dari Favorit' : 'Tambahkan ke Favorit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFav ? Colors.red.shade50 : Colors.blue.shade50,
                foregroundColor: isFav ? Colors.red : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}