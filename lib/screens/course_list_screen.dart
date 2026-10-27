import 'course_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        // Tombol uji coba (download) sudah dihapus karena kita sudah pakai Service Layer
      ),
      body: Consumer<CourseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const Center(child: CircularProgressIndicator());
          if (provider.error != null) return Center(child: Text('Error: ${provider.error}', style: const TextStyle(color: Colors.red)));
          if (provider.courses.isEmpty) return const Center(child: Text('Data kosong.'));

          // TAHAP 10: Membungkus ListView dengan RefreshIndicator
          return RefreshIndicator(
            // Fungsi ini akan dipanggil saat pengguna menarik layar ke bawah
            onRefresh: () => context.read<CourseProvider>().loadCourses(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.courses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: provider.courses[index]);
              },
            ),
          );
        },
      ),
      // Pastikan ada import ini di bagian atas course_list_screen.dart:
      // import 'course_form_screen.dart';
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Membuka form dalam mode Tambah Data (course kosong)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CourseFormScreen()),
          );
        },
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add), // Berubah jadi tombol +
      ),
    );
  }
}