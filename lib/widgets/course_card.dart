import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../screens/course_form_screen.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('${course.code} • ${course.credits} SKS\nStatus: ${course.status}'),
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Tombol Favorit
            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                final isFav = provider.isFavorite(course.code);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.pink : Colors.grey,
                  ),
                  onPressed: () => provider.toggleFavorite(course.code),
                );
              },
            ),
            // 2. Tombol Edit (Tahap 8 & 9)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseFormScreen(course: course),
                  ),
                );
              },
            ),
            // 3. Tombol Hapus (Tahap 7 & 9)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<CourseProvider>().deleteCourse(course);
              },
            ),
          ],
        ),
      ),
    );
  }
}