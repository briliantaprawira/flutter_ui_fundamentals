import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/main_screen.dart'; // Import MainScreen

void main() {
  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);

  runApp(
    ChangeNotifierProvider(
      // Cascade operator (..) otomatis memanggil loadCourses() sesaat setelah provider dibuat
      create: (context) => CourseProvider(repository: courseRepository)..loadCourses(),
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