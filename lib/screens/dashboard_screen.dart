import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';

const String studentName = 'Kadek Brilianta Prawira Arta';
const String studentId = '2415051013';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan jumlah course dan favorit dari Provider
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer v2'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Kotak Identitas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '$studentId • $studentName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // Grid Statistik (Courses & Favorites)
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Courses', style: TextStyle(fontSize: 14)),
                          Text('${provider.courses.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Favorites', style: TextStyle(fontSize: 14)),
                          Text('${provider.favorites.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // List Statis Aktivitas
            const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Card(child: ListTile(title: Text('Git & GitHub'), subtitle: Text('done', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))),
            const Card(child: ListTile(title: Text('Dart Fundamentals'), subtitle: Text('done', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))),
            const Card(child: ListTile(title: Text('State Management'), subtitle: Text('active', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }
}