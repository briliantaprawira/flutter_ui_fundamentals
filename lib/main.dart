import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/course_api_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/main_screen.dart'; // Import MainScreen

void main() {
  // Hanya gunakan satu repository yang terhubung dengan CourseApiService
  final repository = CourseRepository(CourseApiService('https://course-api-pearl.vercel.app'));

  runApp(
    ChangeNotifierProvider(
      // Masukkan variabel 'repository' yang sudah dibuat di atas
      create: (context) => CourseProvider(repository: repository)..loadCourses(),
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
      home: MainScreen(), // Gerbang masuknya adalah MainScreen dengan TabBar
    );
  }
}