import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favCourses = context.watch<CourseProvider>().favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Kuliah Favorit'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: favCourses.isEmpty
          ? const Center(child: Text('Belum ada course favorit.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favCourses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: favCourses[index]);
        },
      ),
    );
  }
}