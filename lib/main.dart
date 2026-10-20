import 'package:flutter/material.dart';
import 'models/course.dart';
import 'services/course_service.dart';

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
      home: Tahap9Page(),
    );
  }
}

class Tahap9Page extends StatefulWidget {
  const Tahap9Page({super.key});

  @override
  State<Tahap9Page> createState() => _Tahap9PageState();
}

class _Tahap9PageState extends State<Tahap9Page> {
  final CourseService _courseService = CourseService();
  List<Course> _courses = [];
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _courseService.loadCourses();

    setState(() {
      _courses = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 9: Service Layer'),
        backgroundColor: Colors.brown,
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

            ElevatedButton.icon(
              onPressed: _fetchData,
              icon: const Icon(Icons.download),
              label: const Text('Muat Data dari Service'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16)
              ),
            ),
            const SizedBox(height: 20),

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_courses.isEmpty)
              const Center(child: Text('Belum ada data. Tekan tombol di atas.'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    final course = _courses[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.library_books, color: Colors.brown),
                        title: Text(course.title),
                        subtitle: Text('Kode: ${course.code} | ${course.credits} SKS'),
                        trailing: Text(course.status, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}