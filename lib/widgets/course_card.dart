import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../screens/course_detail_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Membaca state favorit HANYA untuk course ini
    final isFav = context.watch<CourseProvider>().isFavorite(course.code);

    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          // Navigasi ke halaman detail saat diklik
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
          );
        },
        leading: const Icon(Icons.school, color: Colors.blueAccent),
        title: Text(course.title),
        subtitle: Text('Kode: ${course.code} | ${course.credits} SKS'),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            // Gunakan context.read() karena kita memanggil aksi di dalam tombol
            context.read<CourseProvider>().toggleFavorite(course.code);
          },
        ),
      ),
    );
  }
}