import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../models/course.dart'; // Tambahan wajib untuk mengenali class Course

const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

Future<void> testFetchCourses() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      // TAHAP 3: Konversi JSON List menjadi List<Course>
      final List<Course> apiCourses = data
          .map((json) => Course.fromJson(json as Map<String, dynamic>))
          .toList();

      debugPrint('Berhasil parse ${apiCourses.length} course!');

      // Tampilkan 3 data pertama di console sesuai instruksi
      for (int i = 0; i < 3 && i < apiCourses.length; i++) {
        debugPrint('${i + 1}. ${apiCourses[i].code} - ${apiCourses[i].title} (${apiCourses[i].status})');
      }
    } else {
      debugPrint('Error HTTP: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error jaringan: $e');
  }
}

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              testFetchCourses();
            },
          )
        ],
      ),
      body: Consumer<CourseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const Center(child: CircularProgressIndicator());
          if (provider.error != null) return Center(child: Text('Error: ${provider.error}', style: const TextStyle(color: Colors.red)));
          if (provider.courses.isEmpty) return const Center(child: Text('Data kosong.'));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.courses.length,
            itemBuilder: (context, index) {
              return CourseCard(course: provider.courses[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CourseProvider>().loadCourses(),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}