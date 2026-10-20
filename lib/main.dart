import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'course_provider.dart';

const String studentName = 'Kadek Brilianta Prawira Arta';
const String studentId = '2415051013';

void main() {
  // Menyiapkan Service dan Repository di awal aplikasi
  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);

  runApp(
    // TAHAP 11: Menyuntikkan Repository ke dalam CourseProvider
    ChangeNotifierProvider(
      create: (context) => CourseProvider(repository: courseRepository),
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
      home: Tahap11Page(),
    );
  }
}

class Tahap11Page extends StatefulWidget {
  const Tahap11Page({super.key});

  @override
  State<Tahap11Page> createState() => _Tahap11PageState();
}

class _Tahap11PageState extends State<Tahap11Page> {
  @override
  void initState() {
    super.initState();
    // Meminta Provider memuat data tepat setelah layar pertama kali dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 11: Async State Provider'),
        backgroundColor: Colors.deepPurple,
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

            // Consumer mendengarkan perubahan dari CourseProvider
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, provider, child) {
                  // KONDISI 1: STATE LOADING
                  if (provider.isLoading) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Sedang memuat data...'),
                        ],
                      ),
                    );
                  }

                  // KONDISI 2: STATE ERROR
                  if (provider.error != null) {
                    return Center(
                      child: Text(
                        'Terjadi Kesalahan:\n${provider.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  // KONDISI 3: STATE KOSONG (SUKSES TAPI TANPA DATA)
                  if (provider.courses.isEmpty) {
                    return const Center(child: Text('Data mata kuliah tidak tersedia.'));
                  }

                  // KONDISI 4: STATE SUKSES (DATA ADA)
                  return ListView.builder(
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      final course = provider.courses[index];
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          leading: const Icon(Icons.school, color: Colors.deepPurple),
                          title: Text(course.title),
                          subtitle: Text('Kode: ${course.code} | ${course.credits} SKS'),
                          trailing: Text(course.status, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Tombol refresh
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Memanggil ulang proses load data dengan context.read
          context.read<CourseProvider>().loadCourses();
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}