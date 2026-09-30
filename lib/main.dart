import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString('assets/data/student_data.json');
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  // --- REUSABLE WIDGET 1: KARTU STATISTIK ---
  Widget buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(label, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ),
      ),
    );
  }

  // --- REUSABLE WIDGET 2: KARTU MATERI ---
  Widget buildCourseCard(Map<String, dynamic> course) {
    // Logika conditional untuk menentukan warna dan ikon berdasarkan status
    bool isDone = course['status'] == 'done';
    bool isActive = course['status'] == 'active';

    Color statusColor = isDone ? Colors.green : (isActive ? Colors.orange : Colors.grey);
    IconData statusIcon = isDone ? Icons.check_circle : (isActive ? Icons.play_circle_filled : Icons.schedule);
    String statusText = isDone ? 'Selesai' : (isActive ? 'Berjalan' : 'Rencana');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 32),
        title: Text(course['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
        // Menampilkan kode mata kuliah dan jumlah SKS
        subtitle: Text('${course['code']} • ${course['credits']} SKS'),
        trailing: Text(
          statusText,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Dashboard')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          // Menghitung total SKS secara otomatis dari data JSON
          int totalCredits = 0;
          for (var course in courses) {
            totalCredits += (course['credits'] as int);
          }

          return Column(
            children: [
              // --- KARTU PROFIL (Data dari JSON) ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 46,
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          student['name'] as String,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(student['nim'] as String),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.school, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Mahasiswa Aktif'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // --- SUMMARY CARDS ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    buildStatCard('${courses.length}', 'Total Topik', Icons.library_books, Colors.blue),
                    buildStatCard('$totalCredits', 'Total SKS', Icons.star, Colors.orange),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daftar Materi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              // --- DAFTAR MATERI ---
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index] as Map<String, dynamic>;
                    return buildCourseCard(course);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}